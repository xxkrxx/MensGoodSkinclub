# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

 
  Skinitem.destroy_all
  SkinConcern.destroy_all
  Category.destroy_all
  
  ["ニキビ", "毛穴", "美白"].each do |name| 
     SkinConcern.create(name: name)
  end
  
  
   ["洗顔", "化粧水", "美容液","クリーム"].each do |c_name| 
     Category.create(name: c_name)
  end
  
    ["VT","MEDIHEAL","Dr.Jart+","BIOHEAL BOH","Torriden","魔女工場","Anua", "COSRX","NATURE REPUBLIC", "その他"].each do |s_name| 
     Skinitem.create(name: s_name, skin_concern_id:  SkinConcern.find_by(name: "ニキビ").id, category_id: Category.find_by(name: "化粧水").id )
  end
  
    Admin.create!(
    email: "admin@admin.com",
    password: "123456"
    )