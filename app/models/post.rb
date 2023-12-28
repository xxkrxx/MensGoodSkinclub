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
    if search == "perfect_match"
      if skin_type == "skin_concern"
        skin_concern_ids = SkinConcern.where("name LIKE ?", "#{word}").pluck(:id) # SkinConcernテーブルからnameが部分一致するレコードのIDを取得
        return skin_concern_ids.present? ? Post.where(skin_concern_id: skin_concern_ids) : [] # 取得したIDが存在する場合、それに対応するPostを取得。存在しない場合は空の配列を返す
      elsif skin_type == "skinitem_category"
        skinitem_category_ids = SkinitemCategory.where("name LIKE ?", "#{word}").pluck(:id) # SkinitemCategoryテーブルからnameが部分一致するレコードのIDを取得
        return skinitem_category_ids.present? ? Post.where(skinitem_category_id: skinitem_category_ids) : [] # 取得したIDが存在する場合、それに対応するPostを取得。存在しない場合は空の配列を返す
      else
        category_ids = Category.where("name LIKE ?", "#{word}").pluck(:id) # Categoryテーブルからnameが部分一致するレコードのIDを取得
        return category_ids.present? ? Post.where(category_id: category_ids) : [] # 取得したIDが存在する場合、それに対応するPostを取得。存在しない場合は空の配列を返す
      end
    end

    if search == "forward_match"
      if skin_type == "skin_concern"
        skin_concern_ids = SkinConcern.where("name LIKE ?", "#{word}%").pluck(:id) # SkinConcernテーブルからnameが部分一致するレコードのIDを取得
        return skin_concern_ids.present? ? Post.where(skin_concern_id: skin_concern_ids): [] # 取得したIDが存在する場合、それに対応するPostを取得。存在しない場合は空の配列を返す
      elsif skin_type == "skinitem_category"
        skinitem_category_ids = SkinitemCategory.where("name LIKE ?", "#{word}%").pluck(:id) # SkinitemCategoryテーブルからnameが部分一致するレコードのIDを取得
        return skinitem_category_ids.present? ? Post.where(skinitem_category_id: skinitem_category_ids) : [] # 取得したIDが存在する場合、それに対応するPostを取得。存在しない場合は空の配列を返す
      else
        category_ids = Category.where("name LIKE ?", "#{word}%").pluck(:id) # Categoryテーブルからnameが部分一致するレコードのIDを取得
        return category_ids.present? ? Post.where(category_id: category_ids) : [] # 取得したIDが存在する場合、それに対応するPostを取得。存在しない場合は空の配列を返す
      end
    end

    if search == "backward_match"
      if skin_type == "skin_concern"
        skin_concern_ids = SkinConcern.where("name LIKE ?", "%#{word}").pluck(:id) # SkinConcernテーブルからnameが部分一致するレコードのIDを取得
        return skin_concern_ids.present? ? Post.where(skin_concern_id: skin_concern_ids ) : [] # 取得したIDが存在する場合、それに対応するPostを取得。存在しない場合は空の配列を返す
      elsif skin_type == "skinitem_category"
          skinitem_category_ids = SkinitemCategory.where("name LIKE ?", "%#{word}").pluck(:id) # SkinitemCategoryテーブルからnameが部分一致するレコードのIDを取得
          return skinitem_category_ids.present? ? Post.where(skinitem_category_id: skinitem_category_ids) : [] # 取得したIDが存在する場合、それに対応するPostを取得。存在しない場合は空の配列を返す
      else
        category_ids = Category.where("name LIKE ?", "%#{word}").pluck(:id) # Categoryテーブルからnameが部分一致するレコードのIDを取得
        return category_ids.present? ? Post.where(category_id: category_ids ) : [] # 取得したIDが存在する場合、それに対応するPostを取得。存在しない場合は空の配列を返す
      end
    end

    if search == "partial_match"
      if skin_type == "skin_concern"
        skin_concern_ids = SkinConcern.where("name LIKE ?", "%#{word}%").pluck(:id) # SkinConcernテーブルからnameが部分一致するレコードのIDを取得
        return skin_concern_ids.present? ? Post.where(skin_concern_id: skin_concern_ids) : [] # 取得したIDが存在する場合、それに対応するPostを取得。存在しない場合は空の配列を返す
      elsif skin_type == "skinitem_category"
        skinitem_category_ids = SkinitemCategory.where("name LIKE ?", "%#{word}%").pluck(:id) # SkinitemCategoryテーブルからnameが部分一致するレコードのIDを取得
        return skinitem_category_ids.present? ? Post.where(skinitem_category_id: skinitem_category_ids) : [] # 取得したIDが存在する場合、それに対応するPostを取得。存在しない場合は空の配列を返す
      else
        category_ids = Category.where("name LIKE ?", "%#{word}%").pluck(:id) # Categoryテーブルからnameが部分一致するレコードのIDを取得
        return category_ids.present? ? Post.where(category_id: category_ids) : [] # 取得したIDが存在する場合、それに対応するPostを取得。存在しない場合は空の配列を返す
      end
    end
  end
end
