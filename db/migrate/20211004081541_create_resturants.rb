# frozen_string_literal: true

class CreateResturants < ActiveRecord::Migration[5.2]
  def change
    create_table :resturants do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
