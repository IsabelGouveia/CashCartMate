require 'thor'
require_relative '../config/environment'

class CashCartMateCLI < Thor
  desc "calculate", "Calculates the total price for the given cart items"
  option :cart_items, required: true, type: :string
  def calculate
    items = options[:cart_items].split(',')
    total_price = calculate_total_price(items)
    puts "Total price: #{total_price}€"
  end

  private

  def calculate_total_price(items)
    total_price = 0
    items.each do |item_code|
      product = ::Product.find_by(code: item_code)
      price = product ? product.price : 0
      total_price += price
    end
    total_price.round(2)
  end
end

CashCartMateCLI.start(ARGV)
