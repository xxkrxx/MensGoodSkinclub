class SkinitemCategory < ApplicationRecord
  has_many :skinitems
  has_many :posts
end
