class OrdersController < ApplicationController

  def create
  @order_form = OrderForm.new(order_form_params)

  if @order_form.valid?
    @order_form.save
    redirect_to root_path
  else
    render :new
  end

end
