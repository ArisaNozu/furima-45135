class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product
  before_action :move_to_root, only: [:index, :create]

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_form = OrderForm.new
  end

  def create
    token = order_form_params[:token]

    @order_form = OrderForm.new(order_form_params.merge(user_id: current_user.id, product_id: @product.id))
    if @order_form.valid?
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']
      Payjp::Charge.create(
        amount: @product.price, # ← ここ修正
        card: token,
        currency: 'jpy'
      )
      @order_form.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index
    end
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def move_to_root
    # 自分が出品者、またはすでに購入済みの商品だったらトップに戻す
    return unless @product.user_id == current_user.id || @product.order.present?

    redirect_to root_path
  end

  def order_form_params
    params.require(:order_form).permit(
      :postal_code, :prefecture_id, :city, :house_number,
      :building_name, :phone_number, :token
    )
  end
end
