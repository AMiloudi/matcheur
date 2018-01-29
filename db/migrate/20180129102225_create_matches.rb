class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.datetime :day
      t.string :match
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
