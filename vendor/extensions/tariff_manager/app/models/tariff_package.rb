class TariffPackage < ActiveRecord::Base
  belongs_to :product
  belongs_to :tariff

  def price
    if self[:price].blank?
      tariff.package_price.gsub('$product_price', product.price).gsub(/[^0-9+\-\*\/.()]/).    
    else
      self[:price]
    end
  end
end
