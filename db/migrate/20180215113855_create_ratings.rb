class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.references :chef, foreign_key: true
      t.references :recipe, foreign_key: true
      t.integer :rate

      t.timestamps
    end
  end
end
