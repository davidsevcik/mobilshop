require 'xml'

module XML


  class XmlBatchLoader

    def initialize(reader)
      @reader = reader
      #mapping(&block) if block_given?
    end


    def mapping(top_element, item_element, &block)
      @map = XmlBatchMap.new(top_element, item_element)
      block.call(map)
    end


    def read(&block)
      while @reader.read
        if @reader.node_type == XML::Reader::TYPE_ELEMENT && reader.name == 'Shop_item'
          product = Product.new
          product_vendor = ProductVendor.new
        elsif reader.node_type == XML::Reader::TYPE_ELEMENT && reader.name == 'Cislo'
          reader.read
          product_vendor.id_by_vendor = reader.value if reader.node_type == XML::Reader::TYPE_TEXT
        elsif reader.node_type == XML::Reader::TYPE_ELEMENT && reader.name == 'Popis'
          reader.read
          product.name = reader.value if reader.node_type == XML::Reader::TYPE_TEXT
        end
        puts "#{reader.name}: #{reader.value}"
      end
    end

  end


  private

  class XmlBatchMap

    TEXT_CONTENT = 1
    SUBELEMENTS_CONTENT = 2

    def initialize(top_element, item_element)
      @map = {}
      @top_elememt = top_element
      @item_element = item_element
      #@open_item = false
      @item = {}
    end

    def element(elm_name, key_name)
      @map[elm_name.to_str] = {:contain => TEXT_CONTENT, :key => key_name.to_sym}
    end

    def mapping(top_element, item_element, &block)
      submap = XmlBatchMap.new(top_element, item_element)
      block.call(submap)
      @map[top_element.to_str] = submap
    end

    def process(node)
      if node.node_type == XML::Reader::TYPE_ELEMENT && node.name == @item_element
        #@open_item = true
        @item = {}
      elsif node.node_type == XML::Reader::TYPE_ELEMENT && @map.include?(node.name)
        if @map[node.name].is_a? Hash
          
        end
      end

    end
  end
end