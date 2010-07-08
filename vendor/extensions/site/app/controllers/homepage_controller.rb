class HomepageController < Spree::BaseController
  #caches_action :show

  def index
    @promo = ContentNode.find_by_code('homepage-promo')

    @products = Taxon.find_by_permalink('propagace/na-titulni-strance/').try(:products)
  end
end

