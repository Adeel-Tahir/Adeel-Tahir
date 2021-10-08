# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :status, null: false
      t.integer :total, null: false
      t.datetime :order_time
      t.timestamps
    end
  end
end
