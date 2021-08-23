require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "is valid with all attributes" do
      @category = Category.new(name: "test")
      @product = @category.products.new
      @product.name = "name"
      @product.price = 10
      @product.quantity = 15
      @product.save

      expect(@product).to be_valid
    end

    it "is not valid without a name" do
      @category = Category.new(name: "test")
      @product = @category.products.new
      @product.price = 10
      @product.quantity = 15
      @product.save

      expect(@product).to_not be_valid
    end

    it "is not valid without a price" do
      @category = Category.new(name: "test")
      @product = @category.products.new
      @product.name = "name"
      @product.quantity = 15
      @product.save

      expect(@product).to_not be_valid
    end

    it "is not valid without a quantity" do
      @category = Category.new(name: "test")
      @product = @category.products.new
      @product.name = "name"
      @product.price = 10
      @product.save

      expect(@product).to_not be_valid
    end

    it "is not valid without a category" do
      @category = Category.new(name: "test")
      @product = Product.new
      @product.name = "name"
      @product.price = 10
      @product.quantity = 15
      @product.save

      expect(@product).to_not be_valid
    end

  end
end
