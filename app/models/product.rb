class Product < ApplicationRecord
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :ratings, dependent: :destroy
  mount_uploader :picture, PictureUploader
end
