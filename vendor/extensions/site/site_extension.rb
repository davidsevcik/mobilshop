# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class SiteExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/site"

  # Please use site/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end
  
  def activate
    # customize the checkout state machine
    Checkout.state_machines[:state] = StateMachine::Machine.new(Checkout, :initial => 'address') do
      after_transition :to => 'complete', :do => :complete_order
      #before_transition :to => 'complete', :do => :process_payment
      event :next do
        transition :to => 'confirm', :from => 'address'
        transition :to => 'complete', :from => 'confirm'
      end
    end

    # bypass creation of address objects in the checkouts controller (prevent validation errors)
    CheckoutsController.class_eval do
      def object
        return @object if @object
        @object = parent_object.checkout
        #unless params[:checkout] and params[:checkout][:coupon_code]
        #  @object.creditcard ||= Creditcard.new(:month => Date.today.month, :year => Date.today.year)
        #end
        @object.shipping_method ||= ShippingMethod.first
        @object
      end

      def clear_payments_if_in_payment_state
        true  
      end

      def object_params
        params[:checkout]
      end

      def complete_checkout
        complete_order
        session[:order_id] = nil
        flash[:commerce_tracking] = I18n.t("notice_messages.track_me_in_GA")
        redirect_to ContentNode.find_by_code('complete-order').path
      end
    end

#    Admin::BaseController.class_eval do
#      prepend_before_filter do
#        I18n.locale = 'en'
#      end
#    end
  end
end
