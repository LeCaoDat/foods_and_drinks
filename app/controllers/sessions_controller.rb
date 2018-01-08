class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    remember_login user
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def remember_login user
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == Settings.sessions_controller.checked ? remember(user) : forget(user)
      redirect_to user
    else
      flash.now[:danger] = t ".danger_failed"
      render :new
    end
  end
end
