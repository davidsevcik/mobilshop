module PriceCalc

  def self.price_formula
    Spree::Config[:price_formula]   
  end

  def self.price_formula=(formula)
    check_formula(formula)
    Spree::Config.set(:price_formula => formula)
  end

  def self.from_cost_price(cost_price)
    if Spree::Config[:price_formula].blank?
      cost_price  
    else
      eval(Spree::Config[:price_formula].gsub('cost_price', cost_price.to_s))
    end
  end                                                    

  def self.check_formula(formula)
    from_cost_price(5000)
  end
end