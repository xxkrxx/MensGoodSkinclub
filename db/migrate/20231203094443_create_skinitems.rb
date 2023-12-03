class CreateSkinitems < ActiveRecord::Migration[6.1]
  def change
    create_table :skinitems do |t|
      t.integer :categories_id
      t.integer :skinconcernss_id
      t.string :name
      t.text :introduction
      t.text :thoughts

      t.timestamps
    end
  end
end
