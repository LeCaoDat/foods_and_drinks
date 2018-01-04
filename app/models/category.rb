class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :suggests, dependent: :destroy
  has_many :childs, foreign_key: "parent_id", class_name: Category.name, dependent: :destroy
end
