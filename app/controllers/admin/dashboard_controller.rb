class Admin::DashboardController < ApplicationController
  def show
    @product_count = Product.sum(:quantity)
    @category_count = Category.count
  end
end
