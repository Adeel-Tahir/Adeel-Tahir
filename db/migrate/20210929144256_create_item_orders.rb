# frozen_string_literal: true

class CreateItemOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :item_orders do |t|
      t.belongs_to :item, foreign_key: true, null: false
      t.belongs_to :order, foreign_key: true, null: false

      t.timestamps
    end
  end
end
