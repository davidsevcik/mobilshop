require 'price_calc'

class Admin::PriceSettingsController < Admin::BaseController

  def show
    @price_formula = Spree::Config[:price_formula]
    @errors = {}
  end

  def update
    PriceCalc.price_formula = params[:price_formula]
    flash[:notice] = "Vzorec pro výpočet ceny aktualizován."

    if params[:recount_all_prices]
      Product.all.each do |product|
        product.price = PriceCalc.from_cost_price(product.cost_price)
        product.save
      end
      flash[:notice] += "\nCeny výrobků přepočítány."
    end

    redirect_to admin_price_settings_path
  rescue
    @errors = {:price_formula => 'Nevalidní vzorec'}
    @price_formula = params[:price_formula]
    render :show
  end

end
