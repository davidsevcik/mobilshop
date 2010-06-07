class Tariff < ActiveRecord::Base
  belongs_to :operator
  has_many :tariff_packages
  acts_as_list :scope => :operator

  validates_each :package_price do |model, attr, value|
    begin
      eval_price(1000)
    rescue
      model.errors.add(attr, 'is not valid expression')  
    end
  end


  def eval_price(product_price)
    eval(package_price.gsub('product_price', product_price))
  end
end
