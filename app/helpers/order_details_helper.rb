module OrderDetailsHelper
  def calc_price unit_price, quality
    unit_price * quality
  end
end
