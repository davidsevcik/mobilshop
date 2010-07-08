# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class SimpleCheckoutExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/simple_checkout"

  # Please use simple_checkout/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end
  
  def activate
    Order.class_eval do
      has_one :order_info
    end

    Admin::OrdersController.class_eval do
      def initialize_order_events
        @order_events = %w{cancel resume pay ship}
      end
    end

    # make your helper avaliable in all views
    # Spree::BaseController.class_eval do
    #   helper YourHelper
    # end
  end
end
