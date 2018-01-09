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
    quality = order_detail.quality.to_i
    if quality <= 0 || quality > @product.quality
      flash[:danger] = t ".invalid_quality"
    elsif session[:shopping_cart].any?
      new_item = check_new_item order_detail
      session[:shopping_cart] << order_detail if new_item
      flash[:success] = t ".success_add"
    else
      session[:shopping_cart] << order_detail
      flash[:success] = t ".success_add"
    end
    redirect_to cart_path
  end

  def update
    quality = params[:quality].to_i
    if quality > @product.quality
      flash[:danger] = t ".out_of_stock"
    elsif quality <= 0
      flash[:danger] = t ".invalid_quality"
    else
      session[:shopping_cart].each_with_index do |item, index|
        temp = item.symbolize_keys
        if temp[:product_id] == @product.id
          temp[:quality] = quality
          session[:shopping_cart][index] = temp
        end
      end
    end
    redirect_to cart_path
  end

  def destroy
    session[:shopping_cart].each do |item|
      temp = item.symbolize_keys
      session[:shopping_cart].delete(item) if temp[:product_id] == @product.id
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

  def check_new_item order_detail
    new_item = true
    session[:shopping_cart].each_with_index do |item, index|
      temp = item.symbolize_keys
      next unless temp[:product_id] == order_detail.product_id
      temp[:quality] += order_detail.quality
      session[:shopping_cart][index] = temp
      new_item = false
    end
    new_item
  end
end
