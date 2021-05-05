class Room < ApplicationRecord
  belongs_to :user

  has_many :participants

  mount_uploader :avatar, RoomAvatarUploader
end
