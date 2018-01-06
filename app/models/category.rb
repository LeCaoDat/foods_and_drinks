class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :suggests, dependent: :destroy
  has_many :childs, foreign_key: "parent_id", class_name: Category.name, dependent: :destroy

  def all_product
    product_array = []
    products.each{|e| product_array << e}
    childs.all.find_each do |child|
      child.products.each{|e| product_array << e}
      child.all_product
    end
    product_array
  end
end
