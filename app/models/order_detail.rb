class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product
  delegate :name, to: :product, prefix: "product", allow_nil: true
  delegate :price, to: :product, prefix: "product", allow_nil: true
  delegate :picture, to: :product, prefix: "product", allow_nil: true
end
