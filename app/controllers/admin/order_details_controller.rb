module Admin
  class OrderDetailsController < AdminBaseController
    before_action :find_order, only: :index

    def index
      @order_details = @order.order_details.paginate page: params[:page],
        per_page: Settings.admin.orders.number_of_orders
    end

    private

    def find_order
      @order = Order.find_by id: params[:order_id]
      return if @order
      flash[:danger] = t "admin.orders.not_found_order"
      redirect_to admin_orders_path
    end
  end
end
