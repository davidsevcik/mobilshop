class Admin::TariffPackagesController < Admin::BaseController
  before_filter :load_data

  def index
    @tariff_packages = @tariffs.map do |tariff|
      @product.tariff_packages.find_or_initialize_by_tariff_id(tariff.id)  
    end
  end


  def update_all
    packages = @tariffs.map do |tariff|
      TariffPackage.new(:tariff => tariff, :price => params[:tariffs][tariff.id.to_s][:package_price])    
    end
    @product.tariff_packages = packages

    flash[:notice] = "Ceny tarifních balíčků aktualizovány"
    redirect_to admin_product_tariff_packages_url
  end





  private

  def load_data
    @tariffs = Tariff.all(:include => :operator, :order => [:operator_id, :position])
    @product = Product.find_by_permalink(params[:product_id])
  end

end
