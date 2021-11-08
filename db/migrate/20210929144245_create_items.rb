# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.integer :price, null: false
      t.integer :status, default: 'Available'
      t.belongs_to :resturant, index: true
      t.timestamps
    end
  end
end
