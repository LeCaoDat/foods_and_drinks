class Comment < ApplicationRecord
  belongs_to :product
  belongs_to :user
  scope :desc_created_at, ->{order created_at: :desc}
end
