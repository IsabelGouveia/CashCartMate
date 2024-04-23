require "test_helper"

class CartItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    Product.create!(code: 'GR1', name: 'Green Tea', price: 3.11)
    Product.create!(code: 'SR1', name: 'Strawberries', price: 5.00)
    Product.create!(code: 'CF1', name: 'Coffee', price: 11.23)
  end

  test "total price calculation for buy-one-get-one-free rule" do
    product = Product.find_by(code: 'GR1')
    cart_item = CartItem.new(product: product, quantity: 2)
    assert_equal 3.11, cart_item.total_price

    cart_item = CartItem.new(product: product, quantity: 3)
    assert_equal 6.22, cart_item.total_price
  end

  test "total price calculation for discount for bulk strawberries rule" do
    product = Product.find_by(code: 'SR1')
    cart_item = CartItem.new(product: product, quantity: 2)
    assert_equal 10.00, cart_item.total_price

    cart_item = CartItem.new(product: product, quantity: 3)
    assert_equal 13.50, cart_item.total_price
  end

  test "total price calculation for discount for bulk coffees rule" do
    product = Product.find_by(code: 'CF1')
    cart_item = CartItem.new(product: product, quantity: 2)
    assert_equal 22.46, cart_item.total_price

    cart_item = CartItem.new(product: product, quantity: 3)
    assert_equal 22.46, cart_item.total_price

    cart_item = CartItem.new(product: product, quantity: 4)
    assert_equal 29.95, cart_item.total_price
  end
end
