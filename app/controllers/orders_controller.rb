class OrdersController < ApplicationController

  before_action :set_product

  def index
    @order_form = OrderForm.new
  end

  def create
  @order_form = OrderForm.new(order_form_params)

    if @order_form.valid?
      @order_form.save
      redirect_to root_path
    else
      render :new
    end
  end

  def set_product
    @product = Product.find(params[:product_id])
  end


end
