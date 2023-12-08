class CreateSkinConcerns < ActiveRecord::Migration[6.1]
  def change
    create_table :skin_concerns do |t|
      t.string :skinconcernsname

      t.timestamps
    end
  end
end
