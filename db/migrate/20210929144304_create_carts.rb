# frozen_string_literal: true

class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.belongs_to :user, foreign_key: true
      t.integer :total, default: 0
      t.timestamps
    end
  end
end
