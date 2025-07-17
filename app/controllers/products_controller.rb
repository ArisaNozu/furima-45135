class ProductsController < ApplicationController


  before_action :authenticate_user!, only: [:new, :create,:edit, :update]
  before_action :move_to_index, only: [:edit, :update]




  def index
    @products = Product.includes(:image_attachment).order(created_at: :desc)
  end

  
  def new
    @product = Product.new
  end


  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path, notice: '商品を出品しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  

  def show
    @product = Product.find(params[:id])
  end


  def edit
    @product = Product.find(params[:id])
  end


  def update
  @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit, status: :unprocessable_entity
    end
  end


  private


  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :category_id,
      :condition_id,
      :shipping_cost_id,
      :prefecture_id,
      :shipping_day_id,
      :price,
      :image
    ).merge(user_id: current_user.id)
  end


  def move_to_index
    @product = Product.find(params[:id])
    redirect_to root_path if @product.user != current_user
  end


end
