class CreateCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :carts unless table_exists?(:carts) do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
