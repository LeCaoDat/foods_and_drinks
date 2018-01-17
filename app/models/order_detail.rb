class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product
  delegate :name, to: :product, prefix: :product, allow_nil: true
  delegate :price, to: :product, prefix: :product, allow_nil: true
  delegate :picture, to: :product, prefix: :product, allow_nil: true
  delegate :quantity, to: :product, prefix: :product, allow_nil: true
  after_save :update_order_total_price
  scope :rank, ->(start){
    select("@row:=@row+1 as rank, order_details.*").from("order_details, (SELECT @row:=#{start}) as r")}

  private

  def update_order_total_price
    order.update_attribute :total, (order.total + product_price * quantity)
  end
end
