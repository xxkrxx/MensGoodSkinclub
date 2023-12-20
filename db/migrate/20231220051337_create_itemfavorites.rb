class CreateItemfavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :itemfavorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :skinitem, null: false, foreign_key: true
      t.timestamps
    end
  end
end