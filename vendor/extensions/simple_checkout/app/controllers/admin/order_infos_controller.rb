class Admin::OrderInfosController < Admin::BaseController
  resource_controller :singleton
  before_filter :load_order

  update.wants.html do
    redirect_to :action => 'edit'
  end

  private

    def object
      @object ||= @order.order_info
    end

    def load_order
      @order = Order.find_by_number(params[:order_id])
    end

end