class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.integer :skin_concern_id, null: false
      t.integer :category_id, null: false
      t.integer :skinitem_category_id
      t.string :productname, null: false
      t.string :star, null: false
      t.text :comment, null: false
      t.string :image, null: false
      t.timestamps
    end
  end
end