class User < ApplicationRecord

  extend FriendlyId
  friendly_id :username, use: :slugged

  has_friendship
  
  has_many :rooms, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :messages, dependent: :destroy

  mount_uploader :avatar, UserAvatarUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2, :github]

  def self.from_omniauth(access_token)
    # You can learn which provider used
    # provider = access_token.provider 

    data = access_token.info

    user = User.where(email: data['email']).first

    unless user
      user = User.create(email: data['email'],password: Devise.friendly_token[0,20])
    end
    user
  end

  def on_friendship_created(friendship)
  end
  
  def on_friendship_accepted(friendship)
  end
  
  def on_friendship_blocked(friendship)
  end
  
  def on_friendship_destroyed(friendship)
  end
end
