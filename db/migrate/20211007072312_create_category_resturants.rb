# frozen_string_literal: true

class CreateCategoryResturants < ActiveRecord::Migration[5.2]
  def change
    create_table :categories_resturants, id: false do |t|
      t.belongs_to :category, foreign_key: true, null: false
      t.belongs_to :resturant, foreign_key: true, null: false
      t.timestamps
    end
  end
end
