class Post < ApplicationRecord
  belongs_to :user
  belongs_to :skinitem, optional: true
  belongs_to :skin_concern
  belongs_to :category
  belongs_to :skinitem_category
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
 scope :latest, -> {order(created_at: :desc)}
 scope :old, -> {order(created_at: :asc)}
 scope :star_count, -> {order(star: :desc)}


  validates :productname, presence: true
  validates :comment, presence: true


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


  def self.looks(search, word, skin_type)
    if search == "perfect_match"
      if skin_type == "skin_concern"
          @skin_concern = SkinConcern.find_by("name LIKE?","#{word}")
          return @skin_concern.posts
      elsif skin_type == "skinitem_category"
          @skinitem_category = SkinitemCategory.find_by("name LIKE?","#{word}")
          return @skinitem_category.posts
      else
          @category = Category.find_by("name LIKE?","#{word}")
          return @category.posts
      end
    end

    if search == "forward_match"
      if skin_type == "skin_concern"
        @skin_concern = SkinConcern.find_by("name LIKE?","#{word}%")
        return @skin_concern.posts
      elsif skin_type == "skinitem_category"
        @skinitem_category = SkinitemCategory.find_by("name LIKE?","#{word}%")
        return @skinitem_category.posts
      else
        @category = Category.find_by("name LIKE?","#{word}%")
        return @category.posts
      end
    end


    if search == "backward_match"
      if skin_type == "skin_concern"
        @skin_concern = SkinConcern.find_by("name LIKE?","%#{word}")
        return @skin_concern.posts
      elsif skin_type == "skinitem_category"
        @skinitem_category = SkinitemCategory.find_by("name LIKE?","%#{word}")
        return @skinitem_category.posts
      else
        @category = Category.find_by("name LIKE?","%#{word}")
        return @category.posts
      end
    end

    if search == "partial_match"
      if skin_type == "skin_concern"
        @skin_concern = SkinConcern.find_by("name LIKE?","%#{word}%")
        return @skin_concern.posts
      elsif skin_type == "skinitem_category"
        @skinitem_category = SkinitemCategory.find_by("name LIKE?","%#{word}%")
        return @skinitem_category.posts
      else
        @category = Category.find_by("name LIKE?","%#{word}%")
        @category.posts
        return @posts = Post.all
      end
    end
  end
end


