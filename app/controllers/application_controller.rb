class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include StaticPagesHelper
  include SessionsHelper
  include FiltersHelper
  helper_method :current_order

  def logged_in_user
    return if logged_in?
    flash[:danger] = t "users.please_log_in"
    store_location
    redirect_to login_path
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to root_url unless current_user.is_admin?
  end

  def current_order
    session[:shopping_cart] ||= []
  end
end
