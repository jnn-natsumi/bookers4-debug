class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  has_many :books
  attachment :profile_image,destroy: false

# =====自分がフォローしているユーザーとの関連=====
# フォローする側のUserから見て、フォローされる側のUserを集まるので、親はfollowing_id(フォローする側)
  has_many :active_relationships, class_name:"Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower
# ===========================================

# =====自分がフォローされるユーザーとの関連=====
# フォローされる側のUserから見て、フォローしてくる側のUserを集めるので、親はfollower_id(フォローされる側)
has_many :passive_relationships, class_name:"Relationship", foreign_key: :follower_id
has_many :followers, through: :passive_relationships, source: :following
# =========================================

def followed_by?(user)
  # フォローしたユーザーが過去にフォローしていたか調べる
  passive_relationships.find_by(following_id: user.id).present?
end

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, presence: true, length: {in: 2..20 }
  validates :introduction, length: { maximum: 50 }
end
