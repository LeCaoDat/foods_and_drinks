class CommentsController < ApplicationController
  before_action :logged_in_user, :find_product, only: %i(create)

  def new; end

  def create
    @comment = current_user.comments.build comment_params
    if @product.comments << @comment
      flash[:success] = t ".comment_success"
    else
      flash[:danger] = t ".comment_faild"
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

  def comment_params
    params.require(:comment).permit :content, :product_id
  end
end
