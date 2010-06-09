class TariffPackage < ActiveRecord::Base
  belongs_to :product
  belongs_to :tariff
  

  def price
    if self[:price].blank?
      tariff.eval_package_price(product.price)
    else
      self[:price]
    end
  end



end
