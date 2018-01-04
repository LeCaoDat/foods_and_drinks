class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include StaticPagesHelper
  include SessionsHelper
  include FiltersHelper
  include SessionsHelper

  def logged_in_user
    return if logged_in?
    flash[:danger] = t "users.please_log_in"
    store_location
    redirect_to login_path
  end
end
