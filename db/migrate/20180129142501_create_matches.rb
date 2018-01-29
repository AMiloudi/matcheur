class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.datetime :day
      t.references :studenta
      t.references :studentb

      t.timestamps
    end
    add_foreign_key :matches, :users, column: :studenta_id, primary_key: :id
    add_foreign_key :matches, :users, column: :studentb_id, primary_key: :id
  end
end
