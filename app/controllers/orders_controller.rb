class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product
  before_action :move_to_root, only: [:index, :create]

  def index
    @order_form = OrderForm.new
  end

  def create
    @order = Order.new(order_params)
    if @order.valid?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵→鍵情報を環境変数に設定
      Payjp::Charge.create(
        amount: order_params[:price],  # 商品の値段
        card: order_params[:token],    # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )
      @order.save
      return redirect_to root_path
    else
      render :index
    end
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def move_to_root
    # 自分が出品者、またはすでに購入済みの商品だったらトップに戻す
    if @product.user_id == current_user.id || @product.order.present?
      redirect_to root_path
    end
  end

  def order_form_params
    params.require(:order_form).permit(
      :postal_code, :prefecture_id, :city, :house_number,
      :building_name, :phone_number, :token
    )
  end



end
