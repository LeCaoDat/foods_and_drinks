class Order < ApplicationRecord
  enum status: {pending: Settings.orders.pending_status, accept: Settings.orders.accept_status,
    reject: Settings.orders.reject_status}
  belongs_to :user
  has_many :order_details, dependent: :destroy
  delegate :email, to: :user, prefix: :user, allow_nil: true
  delegate :name, to: :user, prefix: :user, allow_nil: true
  scope :created_at_desc, ->{order created_at: :desc}
end
