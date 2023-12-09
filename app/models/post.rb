class Post < ApplicationRecord
  belongs_to :user
  belongs_to :skinitem
  belongs_to :skin_concern
  
  
  has_one_attached :image
  
end
