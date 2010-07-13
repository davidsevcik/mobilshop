# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class TariffManagerExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/tariff_manager"

  # Please use tariff_manager/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end
  
  def activate
    OptionValue.class_eval do
      belongs_to :tariff
    end

    Variant.additional_fields = []

    Variant.class_eval do
      after_create :assign_tariff_option
      #before_validation :calc_price

      def tariff
        @tariff ||= option_values.first.try(:tariff)
      end

      def tariff=(tariff)
        @tariff = tariff
      end

#      def package_price
#        if price == -1
#          tariff.eval_package_price(product)
#        else
#          price
#        end
#      end

      def assign_tariff_option
        if @tariff
          tariff_option_value = OptionValue.find_by_tariff_id(@tariff.id)
          option_values << tariff_option_value 
        end
      end


      def check_price
        price = if cost_price == -1
          tariff.eval_package_price(product)
        else
          cost_price
        end

        price = 0 if price < 0
      end

    end


    Product.class_eval do

      named_scope :tariffable, :conditions => { :is_tariffable => true }
      

      def init_tariff_packages
        option_types = [OptionType.find_by_name('tariff_package')]

        Tariff.all.each do |tariff|
          variant = variants.build(:cost_price => '-1')
          variant.tariff = tariff
          variant.save
        end
      end
    end


#    ProductsController.class_eval do
#      alias_method :orig_load_data, :load_data
#
#      def load_data
#        orig_load_data
#
#        filled_out_tariffs = []
#        @tariff_packages = []
#        @product.variants.each do |variant|
#          tariff = variant.option_values.first.try(:tariff)
#          continue if tariff.nil?
#          @tariff_packages << tariff.attributes.merge({        
#            'operator_name' => tariff.operator.name,
#            'package_price' => variant.price})
#
#          filled_out_tariffs << tariff.id
#        end
#
#        Tariff.published.each do |tariff|
#          unless filled_out_tariffs.include?(tariff.id)
#            @tariff_packages << tariff.attributes.merge({
#              'operator_name' => tariff.operator.name,
#              'package_price' => tariff.eval_package_price(@product)})
#          end
#        end
#      end
#    end

    # make your helper avaliable in all views
    # Spree::BaseController.class_eval do
    #   helper YourHelper
    # end
  end
end
