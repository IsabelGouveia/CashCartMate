class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def total_price
    case product.code
    when 'GR1'
      buy_one_get_one_free
    when 'SR1'
      discount_for_bulk_strawberries
    when 'CF1'
      discount_for_bulk_coffees
    else
      quantity * product.price
    end
  end

  private

  def buy_one_get_one_free
    (quantity / 2 + quantity % 2) * product.price
  end

  def discount_for_bulk_strawberries
    quantity >= 3 ? quantity * 4.50 : quantity * product.price
  end

  def discount_for_bulk_coffees
    quantity >= 3 ? quantity * (2.0 / 3) * product.price : quantity * product.price
  end 
end
