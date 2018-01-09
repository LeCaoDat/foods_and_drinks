class OrdersController < ApplicationController
  before_action :logged_in_user, only: %i(index)

  def index
    @orders = @current_user.orders.paginate page: params[:page],
      per_page: Settings.orders.number_of_orders
  end
end
