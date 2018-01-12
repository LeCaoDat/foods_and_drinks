module Admin
  module CategoriesHelper
    def render_category_select_tag form, category, id = 0
      id = category.id if category.id
      categories = Category.not_self(id)
      form.collection_select :parent_id, categories, :id, :name, {}, class: "form-control"
    end
  end
end
