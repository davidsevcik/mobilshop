class SimpleCheckoutController < Spree::BaseController

  before_filter :load_order

  def contact
    @order_info = @order.build_order_info
  end

  def contact_process
    @order_info = @order.build_order_info(params[:order_info])
    if @order_info.save
      redirect_to :action => :summary
    else
      render :action => :contact
    end
  end


  def summary

  end


  def confirm
    @order.complete!
    redirect_to ContentNode.find_by_code('complete-order').path
  end


  private

  def load_order
    @order = Order.find_by_number(params[:order_number])
  end
end