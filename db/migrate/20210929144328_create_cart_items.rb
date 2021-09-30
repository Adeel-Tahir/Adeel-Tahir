class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.belongs_to :carts
      t.belongs_to :items
      t.timestamps
    end
  end
end
