class RatingsController < ApplicationController
  before_action :logged_in_user, :find_product, :check_rating, only: %i(create)

  def new; end

  def create
    @rating = current_user.ratings.build rating_params
    if @product.ratings << @rating
      flash[:success] = t ".rating_success"
    else
      flash[:danger] = t ".rating_faild"
    end
    redirect_to @product
  end

  private

  def find_product
    @product = Product.find_by id: params[:product_id]
    return if @product
    flash[:danger] = t "products.not_found_product"
    redirect_to root_path
  end

  def check_rating
    @rating = Rating.find_by user_id: @current_user.id, product_id: @product.id
    return unless @rating
    flash[:danger] = t "products.had_been_rating"
    redirect_to @product
  end

  def rating_params
    params.require(:rating).permit :rate, :product_id
  end
end
