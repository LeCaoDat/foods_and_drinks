module StaticPagesHelper
  def find_product category, page_category
    return unless category && category.childs.any?
    products = category.all_product
    products.paginate page: page_category, per_page: Settings.home.number_of_products
  end
end
