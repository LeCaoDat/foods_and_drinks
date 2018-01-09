module CartsHelper
  def total_price order_details
    total = 0
    order_details.each do |item|
      total += calc_price item.product_price, item.quality
    end
    total
  end
end
