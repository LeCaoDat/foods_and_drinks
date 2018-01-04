module StaticPagesHelper
  def find_product category, page_category
    return unless category && category.childs.any?
    products = recursive_product category
    products.paginate page: page_category, per_page: Settings.home.number_of_products
  end

  def recursive_product category, products = category.products
    category.childs.each do |child|
      products << child.products
      recursive_product child, products
    end
    products
  end
end
