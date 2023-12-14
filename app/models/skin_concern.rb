class SkinConcern < ApplicationRecord
  has_many :users
  has_many :skinitems
end
