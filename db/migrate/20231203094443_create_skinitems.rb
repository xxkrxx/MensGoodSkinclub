class CreateSkinitems < ActiveRecord::Migration[6.1]
  def change
    create_table :skinitems do |t|
      t.integer :categories_id
      t.integer :skinconcernss_id
      t.string :productname
      t.text :introduction

      t.timestamps
    end
  end
end
