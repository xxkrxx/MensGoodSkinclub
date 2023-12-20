class CreateSkinitems < ActiveRecord::Migration[6.1]
  def change
    create_table :skinitems do |t|
      t.integer :use_id
      t.integer :category_id
      t.integer :skin_concern_id
      t.integer :skinitem_category_id
      t.string :name
      t.string :product_name
      t.text :introduction

      t.timestamps
    end
  end
end