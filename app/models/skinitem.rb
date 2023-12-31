class Skinitem < ApplicationRecord
  has_many :posts
  belongs_to :category
  belongs_to :skin_concern
  belongs_to :skinitem_category
  
  has_many :itemfavorites, dependent: :destroy
  
  validates :product_name, presence: true
  validates :introduction, presence: true
  
  def favorited?(user)
     itemfavorites.exists?(user_id: user.id)
  end



    has_one_attached :image

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end

    image.variant(resize_to_limit: [width, height]).processed
  end


end