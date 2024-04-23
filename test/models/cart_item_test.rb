require "test_helper"

class CartItemTest < ActiveSupport::TestCase
  def setup
    # Setup products for testing
    ActiveRecord::Base.transaction do
      Product.create!(code: 'GR1', name: 'Green Tea', price: 3.11)
      Product.create!(code: 'SR1', name: 'Strawberries', price: 5.00)
      Product.create!(code: 'CF1', name: 'Coffee', price: 11.23)
    end
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

  test "total price calculation for GR1 and SR1" do
    gr1 = Product.find_by(code: 'GR1')
    sr1 = Product.find_by(code: 'SR1')

    cart_item_gr1 = CartItem.new(product: gr1, quantity: 1)
    cart_item_sr1 = CartItem.new(product: sr1, quantity: 3)

    total_price_expected = 16.61
    total_price_actual = cart_item_gr1.total_price + cart_item_sr1.total_price
    assert_equal total_price_expected, total_price_actual
  end

  test "total price calculation for multiple products" do
    gr1 = Product.find_by(code: 'GR1')
    sr1 = Product.find_by(code: 'SR1')
    cf1 = Product.find_by(code: 'CF1')

    cart_item_gr1 = CartItem.new(product: gr1, quantity: 1)
    cart_item_cf1 = CartItem.new(product: cf1, quantity: 3)
    cart_item_sr1 = CartItem.new(product: sr1, quantity: 1)

    total_price_expected = 30.57
    total_price_actual = cart_item_gr1.total_price + cart_item_cf1.total_price + cart_item_sr1.total_price
    assert_equal total_price_expected, total_price_actual
  end
end
