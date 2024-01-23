class Post < ApplicationRecord
  # リレーションシップの定義
  belongs_to :user
  belongs_to :skinitem, optional: true
  belongs_to :skin_concern
  belongs_to :category
  belongs_to :skinitem_category
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :tags, dependent: :destroy

  # スコープの定義
  scope :latest, -> { order(created_at: :desc) }
  scope :old, -> { order(created_at: :asc) }
  scope :star_count, -> { order(star: :desc) }

  # バリデーションの定義
  validates :productname, presence: true
  validates :comment, presence: true
  validates :star, presence: true

  # Active Storageを使用した画像の添付
  has_one_attached :image

  # 画像の取得（リサイズも含む）
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end

    image.variant(resize_to_limit: [width, height]).processed
  end

  # お気に入り登録の確認
  def favorites?(user)
    return false if user.nil? || self.nil?
    self.favorites.exists?(user_id: user.id)
  end

  # 検索条件に基づく投稿の取得
  def self.looks(search, word, skin_type)
      if skin_type == "skin_concern"
        Post.where(skin_concern_id: skin_concern_ids(search, word))
      elsif skin_type == "skinitem_category"
         Post.where(skinitem_category_id: skinitem_category_ids(search, word))
      else
         Post.where(category_id: category_ids(search, word))
      end
  end

  private

  def self.category_ids(search, word)
     Category.where("name LIKE ?", word_match(search, word)).pluck(:id)
  end

  def self.skinitem_category_ids(search, word)
    SkinitemCategory.where("name LIKE ?", word_match(search, word)).pluck(:id)
  end

  def self.skin_concern_ids(search, word)
    SkinConcern.where("name LIKE ?", word_match(search, word)).pluck(:id)
  end

  def self.word_match(search, word)
    if search == "perfect_match"
      "%#{word}"
    elsif search == "forward_match"
      "#{word}%"
    elsif search == "backward_match"
      "%#{word}"
    else
      "%#{word}%"
    end
  end


end
