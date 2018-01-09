module Admin
  class UsersController < AdminBaseController
    def index
      @users =
        if params[:search]
          User.search(params[:search]).paginate page: params[:page],
            per_page: Settings.admin.users.number_of_users
        else
          User.all.paginate page: params[:page],
            per_page: Settings.admin.users.number_of_users
        end
    end

    def destroy
      if @user.destroy
        flash[:success] = t ".delete_success"
      else
        flash[:danger] = t ".delete_failed"
      end
      redirect_to admin_users_path
    end
  end
end
