require "spec"

describe XmlBatchLoader do

  it "should load xml to model" do

    loader = XmlBatchLoader.new(reader)

    loader.mapping('Shop', 'Shop_item') do |map|
      map.element 'Cislo', 'id_by_vendor'
      map.element 'Popis', 'name'
      map.element 'Kategorie_zbozi', 'category'
      map.mapping('Technicke_parametry', 'Technicky_parametr') do |submap|
        submap.element 'Name', 'name'
        submap.element 'Value', 'value'
      end
    end

    loader.read do |item|
      p item  
    end



    #To change this template use File | Settings | File Templates.
    true.should == false
  end
end