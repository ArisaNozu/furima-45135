class ProductsController < ApplicationController

  def index
  end

  def new
  @product = Product.new
  end


  private




  def product_params
    params.require(:product).permit(:content, :image).merge(user_id: current_user.id)
  end

  
end
