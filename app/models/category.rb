class Category < ApplicationRecord
  has_many :skinitems, dependent: :destroy
end
