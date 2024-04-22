class AddProducts < ActiveRecord::Migration[7.1]
  def up
    Product.create!(code: 'GR1', name: 'Green Tea', price: 3.11)
    Product.create!(code: 'SR1', name: 'Strawberries', price: 5.00)
    Product.create!(code: 'CF1', name: 'Coffee', price: 11.23)
  end

  def down
    Product.where(code: ['GR1', 'SR1', 'CF1']).destroy_all
  end
end
