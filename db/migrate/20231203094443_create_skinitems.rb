class CreateSkinitems < ActiveRecord::Migration[6.1]
  def change
    create_table :skinitems do |t|
      t.integer :category_id
      t.integer :skin_concern_id
      t.string :name
      t.text :introduction

      t.timestamps
    end
  end
end