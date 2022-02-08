require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do

    it "is able to save when all properties included" do
      @category = Category.new
      @product = Product.new({
        name: 'usb stick',
        price: 1000,
        quantity: 25,
        category: @category
      })
      expect(@product).to be_valid
    end
    
    it "is not able to save when name property is not included" do
      @category = Category.new
      @product = Product.new({
        price: 1000,
        quantity: 25,
        category: @category
      })
      expect(@product).to_not be_valid
      expect(@product.errors.messages).to eq ({:name=>["can't be blank"]})
    end
    
    it "is not able to save when price property is not included" do
      @category = Category.new
      @product = Product.new({
        name: 'usb stick',
        quantity: 25,
        category: @category
      })
      expect(@product).to_not be_valid
      expect(@product.errors.messages).to eq ({:price=>["is not a number", "can't be blank"], :price_cents=>["is not a number"]})
    end
    
    it "is not able to save when quantity property is not included" do
      @category = Category.new
      @product = Product.new({
        name: 'usb stick',
        price: 1000,
        category: @category
      })
      expect(@product).to_not be_valid
      expect(@product.errors.messages).to eq ({:quantity=>["can't be blank"]})
    end
    
    it "is not able to save when name property is not included" do
      @product = Product.new({
        name: 'usb stick',
        price: 1000,
        quantity: 25
      })
      expect(@product).to_not be_valid
      expect(@product.errors.messages).to eq ({:category=>["can't be blank"]})
    end
  end
end