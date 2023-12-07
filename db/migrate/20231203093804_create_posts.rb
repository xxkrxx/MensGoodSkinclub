class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :categories_id
      t.integer :skinconcernss_id
      t.string :productname
      t.float :evaluation
      t.text :comment

      t.timestamps
    end
  end
end
