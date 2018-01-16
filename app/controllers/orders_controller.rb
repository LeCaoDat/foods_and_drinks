class OrdersController < ApplicationController
  before_action :logged_in_user, only: %i(index destroy)
  before_action :find_order, only: %i(destroy)

  def index
    @orders = @current_user.orders.paginate page: params[:page],
      per_page: Settings.orders.number_of_orders
  end

  def destroy
    if @order.pending? && @order.destroy
      flash[:success] = t ".delete_success"
    else
      flash[:danger] = t ".delete_failed"
    end
    redirect_to orders_path
  end

  private

  def find_order
    @order = @current_user.orders.find_by id: params[:id]
    return if @order
    flash[:danger] = t "orders.not_found_order"
    redirect_to orders_path
  end
end
