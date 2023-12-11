class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :skin_concern_id
      t.integer :skinitem_id 
      t.string :productname
      t.string :star
      t.text :comment
      t.string :image
      t.timestamps
    end
  end
end