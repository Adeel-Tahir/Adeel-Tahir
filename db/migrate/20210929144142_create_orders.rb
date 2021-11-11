# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :status, null: false
      t.integer :total, default: 'ordered'
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
