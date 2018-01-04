class ProductsController < ApplicationController
  before_action :load_product, only: %i(show)

  def new; end

  def show
    @rating = @product.ratings.build
    @comment = @product.comments.build
    @comments = @product.comments.desc_created_at.paginate page: params[:page],
      per_page: Settings.products.number_of_comment
    respond_to do |format|
      format.html
      format.json{render json: @comments}
      format.js
    end
  end

  private

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:danger] = t "products.not_found_product"
    redirect_to root_path
  end
end
