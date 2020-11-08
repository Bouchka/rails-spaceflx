class CreateSpaces < ActiveRecord::Migration[6.0]
  def change
    create_table :spaces do |t|
      t.string :name
      t.integer :capacity
      t.string :area
      t.float :price_per_day
      t.text :description

      t.timestamps
    end
  end
end
