class CartsController < ApplicationController
  before_action :load_product, only: %i(create destroy update)
  before_action :current_order, only: %i(show)

  def show
    @order_details = []
    session[:shopping_cart].each do |e|
      @order_details << OrderDetail.new(e)
    end
  end

  def create
    order_detail = OrderDetail.new item_params
    result = find_product_in_cart(order_detail.product_id)
    quality = order_detail.quality.to_i
    if result
      check_quality result, quality
    else
      session[:shopping_cart] << order_detail
      flash[:success] = t ".success_add"
    end
    redirect_to cart_path
  end

  def update
    quality = params[:quality].to_i
    if quality > @product.quality || quality <= 0
      flash[:danger] = t ".invalid_quantity"
    else
      result = find_product_in_cart(@product.id)
      result["quality"] = quality
    end
    redirect_to cart_path
  end

  def destroy
    session[:shopping_cart].each do |item|
      session[:shopping_cart].delete(item) if item["product_id"] == @product.id
    end
    flash[:success] = t ".success_delete"
    redirect_to cart_path
  end

  private

  def item_params
    params.permit :product_id, :quality
  end

  def load_product
    current_order
    @product = Product.find_by id: params[:product_id]
    return if @product
    flash[:danger] = t "products.not_found_product"
    redirect_to root_path
  end

  def find_product_in_cart product_id
    result = nil
    session[:shopping_cart].each do |item|
      next unless item["product_id"] == product_id
      result = item
    end
    result
  end

  def check_quality result, quality
    if result["quality"] + quality > @product.quality
      flash[:danger] = t ".invalid_quantity"
    else
      result["quality"] += quality
    end
  end
end
