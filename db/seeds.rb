# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


  SkinitemCategory.destroy_all
  SkinConcern.destroy_all
  Category.destroy_all
  
  skinconcerns = %w(
  ニキビ 毛穴 美白 
  )
  skinconcerns.each do |skinconcern|
    SkinConcern.create!(name: skinconcern)
  end

  categories = %w(
  洗顔 化粧水 美容液 クリーム
  )
  categories.each do |category|
    Category.create!(name: category)
  end

  skinitem_categories = %w(
    VT MEDIHEAL Dr.Jart BIOHEALBOH Torriden 魔女工場 Anua COSRX NATUREREPUBLIC その他
  )
  skinitem_categories.each do |skinitemcategory|
    SkinitemCategory.create!(name: skinitemcategory)
  end



  Admin.create!(
  email: "admin@admin.com",
  password: "123456"
  )

  15.times do |n|
  User.create!(
    name: "ryoga#{n + 1}",
    email: "public#{n + 1}@public.com",
    password: "111111"
    )
  end
  

