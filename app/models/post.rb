class Post < ApplicationRecord
  belongs_to :user
  belongs_to :skinitem
  belongs_to :skin_concern
  belongs_to :category
  belongs_to :skinitem_category
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  
  
  has_one_attached :image
  
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end

    image.variant(resize_to_limit: [width, height]).processed
  end
  
  
  def favorites?(user)
    return false if user.nil? || self.nil? 
    self.favorites.exists?(user_id: user.id)
  end
  
  
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @post = Post.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @post = Post.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @post = Post.where("name LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end
  
end
