namespace :spree do
  namespace :extensions do
    namespace :product_loader do
      desc "Copies public assets of the Product Loader to the instance public/ directory."
      task :update => :environment do
        is_svn_git_or_dir = proc {|path| path =~ /\.svn/ || path =~ /\.git/ || File.directory?(path) }
        Dir[ProductLoaderExtension.root + "/public/**/*"].reject(&is_svn_git_or_dir).each do |file|
          path = file.sub(ProductLoaderExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end


      desc "Import changed products from source."
      task :load => :environment do
        timestamp = Time.now.strftime('%Y%m%d%H%M%S')
        LOGFILE = File.join(RAILS_ROOT, 'log', "setos_import_#{RAILS_ENV}_#{timestamp}.log")
        log = ActiveSupport::BufferedLogger.new(LOGFILE)

        require 'xml'
        require 'net/http'
        require 'uri'
        require 'action_controller/test_process'

        operator_taxonomy = Taxonomy.find_by_name('Operátor')
        category_to_taxon_map = {
          'Mobilní telefony -  volné' => operator_taxonomy.taxons.find_by_name('žádný'),
          'Mobilní telefony - T-Mobile' => operator_taxonomy.taxons.find_by_name('T-Mobile'),
          'Mobilní telefony - O2' => operator_taxonomy.taxons.find_by_name('O2')
        }
        vyrobce_taxonomy = Taxonomy.find_by_name('Výrobce')

        sample_file = File.join(File.dirname(__FILE__), '..', '..', 'test', 'mobilie.xml')
        puts sample_file

        reader = XML::Reader.file(sample_file, :options => XML::Parser::Options::NOBLANKS)

        while reader.read
          if reader.node_type == XML::Reader::TYPE_ELEMENT && reader.name == 'Shop_item'
            item = Hash.from_xml(reader.read_outer_xml)
            unless item.empty?
              item = item['Shop_item']
              
              if category_to_taxon_map.include?(item['Kategorie_zbozi'])

                product_vendor = ProductVendor.find_by_code(item['Cislo'])
                product = product_vendor ? product_vendor.product : Product.new()

                product.name = item['Popis']
                product.description = item['Obsah_baleni']
                product.available_on = Time.new.to_s
                product.count_on_hand = item['Dostupnost']
                product.price = item['Individualni_cena_zakaznika'].sub(',', '.')
                product.sku = item['EAN']
                
                if product.save
                  puts product.name
                  log.info "INFO: Product #{product.name} saved"

                  product.taxons << category_to_taxon_map[item['Kategorie_zbozi']]
                  product.product_vendors.create(:code => item['Cislo']) if product.product_vendors.empty?

                  if product.images.empty?
                    uri = URI.parse(item['Obrazek'])
                    resp = Net::HTTP.get_response(uri)
                    if resp.code == '200'
                      tmp = File.new("/tmp/#{item['Cislo']}_image", 'wb')
                      tmp.write(resp.body)
                      tmp.close
                      product.images.create(:attachment => ActionController::TestUploadedFile.new(tmp.path, resp.content_type, true))

                      File.delete(tmp.path)
                    end
                  end

                  if !item['Vyrobce'].blank? && !product.taxons.exists?(:name => item['Vyrobce'])
                    taxon = vyrobce_taxonomy.taxons.find_or_create_by_name(item['Vyrobce'])
                    taxon.move_to_child_of(vyrobce_taxonomy.root) if taxon.parent_id.nil?
                    product.taxons << taxon
                  end


                  unless item['Technicke_parametry'].blank?
                    item['Technicke_parametry']['Technicky_parametr'].each do |param|
                      if param.include?('Name') && param.include?('Value') && !param['Name'].blank? && !param['Value'].blank?
                        puts param['Name'] + ': ' + param['Value']
                        property = Property.find_or_create_by_name_and_presentation(param['Name'].downcase, param['Name'])
                        unless product.product_properties.exists?(:property_id => property.id)
                          product.product_properties.create(:property_id => property.id, :value => param['Value'])
                        end
                      end
                    end
                  end
                  
                else
                  log.error "ERROR: #{product.errors.inspect}"
                  p product.errors
                end


                #puts product
              end
            end
          end
        end

        reader.close

      end
    end
  end
end