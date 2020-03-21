class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one_attached :avatar
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  validates :name,          presence: true,   length: { maximum: 30 }
  validates :username,      presence: true,   length: { maximum: 30 },   uniqueness: true
  validates :description,   presence: true,   length: { maximum: 500 }
  validate :avatar_check

  def avatar_check
    if avatar.present?
      unless avatar.content_type.in?(%(image/jpeg image/png))
        errors.add(:avatar, 'にはjpegまたはpngファイルを添付してください')
      end
    else
      unless avatar.attached?
        errors.add(:avatar, 'ファイルを添付してください')
      end
    end
  end
end
