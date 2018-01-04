class StaticPagesController < ApplicationController
  def home
    @food = Category.find_by id: Settings.categories.food_default_id
    @drink = Category.find_by id: Settings.categories.drink_default_id
    @food_product = find_product @food, params[:page_food]
    @drink_product = find_product @drink, params[:page_drink]
    respond_to do |format|
      format.html
      format.json{render json: @food_product}
      format.json{render json: @drink_product}
      format.js
    end
  end
end
