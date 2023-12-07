class Post < ApplicationRecord
  belongs_to :user
  belongs_to :skinitem
  
  has_one_attached :image
  
end
