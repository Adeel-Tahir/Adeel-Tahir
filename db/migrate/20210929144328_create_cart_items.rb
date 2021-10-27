# frozen_string_literal: true

class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.integer :quantity, default: 0
      t.belongs_to :cart, foreign_key: true, null: false
      t.belongs_to :item, foreign_key: true, null: false
      t.integer :subtotal, default: 0
      t.timestamps
    end
  end
end
