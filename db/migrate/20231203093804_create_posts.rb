class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :customer_id
      t.string :name
      t.string :evaluation
      t.string :floort
      t.text :comment

      t.timestamps
    end
  end
end
