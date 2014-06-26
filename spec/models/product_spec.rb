require "spec_helper"

describe Product do
  it "should create new product" do
    product = Product.create! name: "Test product", price: 300
    Product.find(product.id).should eq(product)
  end

  it "should validate numericality_of price" do
    should validate_numericality_of(:price).is_greater_than(0).is_less_than(1000000)
  end

  it "should validate presence name and price" do
    should validate_presence_of(:name)
    should validate_presence_of(:price) 
  end
end