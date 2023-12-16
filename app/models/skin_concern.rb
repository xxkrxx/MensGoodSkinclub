class SkinConcern < ApplicationRecord
  has_many :users
  has_many :skinitems
  has_many :posts
end
