class CreateCategorizations < ActiveRecord::Migration[5.2]
  def change
    create_table :categorizations do |t|
      t.belongs_to :items
      t.belongs_to :categories

      t.timestamps
    end
  end
end
