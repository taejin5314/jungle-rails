class Admin::DashboardController < ApplicationController
  def show
    @item_count = Product.count
    @category_count = Category.count
  end
end
