module OrderDetailsHelper
  def calc_price unit_price, quality
    unit_price * quality
  end

  def no_order counter
    counter + 1
  end
end
