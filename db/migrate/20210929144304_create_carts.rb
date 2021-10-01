class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.integer :quantity
      t.belongs_to :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
