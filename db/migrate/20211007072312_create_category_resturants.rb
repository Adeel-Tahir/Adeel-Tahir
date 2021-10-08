class CreateCategoryResturants < ActiveRecord::Migration[5.2]
  def change
    create_table :category_resturants, id: false do |t|
      t.belongs_to :category,foreign_key: true, null: false
      t.belongs_to :resturant,foreign_key: true, null: false
    end
  end
end
