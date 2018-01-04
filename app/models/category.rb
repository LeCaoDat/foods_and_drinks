class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :suggests, dependent: :destroy
  has_many :childs, foreign_key: "parent_id", class_name: Category.name, dependent: :destroy
  scope :root_categories, ->{where parent_id: Settings.categories.root_id}

  def find_childs_id_to_array
    children_array = []
    childs.all.find_each do |child|
      children_array << child.id
      children_array << child.find_childs_id_to_array
    end
    children_array.flatten
  end

  def all_children level = 0
    children_array = []
    level += 1
    childs.all.find_each do |child|
      child.name = I18n.t("categories.level") * level + child.name
      children_array << child
      children_array << child.all_children(level)
    end
    children_array.flatten
  end
end
