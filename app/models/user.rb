class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Active Storageを使用した画像の添付
  has_one_attached :image

  # リレーションシップの定義
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :skinitems, dependent: :destroy
  has_many :itemfavorites, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_items, through: :likes, source: :item


  # バリデーションの定義
  validates :name, presence: true, uniqueness: true, length: { in: 2..20 }
  validates :profile, length: { maximum: 200 }

  # プロフィール画像の添付
  attachment :profile_image

  # ゲストユーザーの作成または取得
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = 'guest'
      user.password = SecureRandom.urlsafe_base64
    end
  end


  # 名前の検索条件に基づくユーザーの取得
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE ?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE ?", "#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE ?", "%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE ?", "%#{word}%")
    else
      @user = User.all
    end
  end
end
