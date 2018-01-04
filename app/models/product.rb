class Product < ApplicationRecord
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :ratings, dependent: :destroy
  mount_uploader :picture, PictureUploader
  scope :filter_by_alphabet, ->(alpha){where("name LIKE ?", "#{alpha}%") if alpha.present?}
  scope :filter_by_name, ->(name){where("name LIKE ?", "%#{name}%") if name.present?}
  scope :filter_by_category, ->(category_id){where(category_id: category_id) if category_id.present?}
  scope :filter_by_min_price, ->(min_price){where("price >= ?", min_price) if min_price.present?}
  scope :filter_by_max_price, ->(max_price){where("price <= ?", max_price) if max_price.present?}
  scope :filter_by_rate, (lambda do |rate|
    select("products.*").joins("JOIN ratings r ON products.id = r.product_id")
    .group(:id, :name, :price, :quality, :detail, :picture, :category_id, :created_at, :updated_at)
    .having("ROUND(AVG(rate)) = ?", rate)
  end)

  def average_rating
    (result = ratings.average :rate) ? result : 0
  end

  def self.filter_product params
    result = Product.all
    result = result.filter_by_alphabet params[:alpha] if params[:alpha].present?
    result = result.filter_by_name params[:name] if params[:name].present?
    result = result.filter_by_category params[:category_id] if params[:category_id].present?
    result = result.filter_by_min_price params[:min_price] if params[:min_price].present?
    result = result.filter_by_max_price params[:max_price] if params[:max_price].present?
    result = result.filter_by_rate params[:rate] if params[:rate].present?
    result
  end
end
