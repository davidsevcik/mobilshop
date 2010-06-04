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
    Product.class_eval do
      has_many :tariff_packages
    end

    Float.class_eval do
      define_method :round_to do |x|
        (self * 10**x).round.to_f / 10**x
      end

      define_method :ceil_to do |x|
        (self * 10**x).ceil.to_f / 10**x
      end

      define_method :floor_to do |x|
        (self * 10**x).floor.to_f / 10**x
      end
    end

    # make your helper avaliable in all views
    # Spree::BaseController.class_eval do
    #   helper YourHelper
    # end
  end
end
