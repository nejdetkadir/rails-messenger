class Room < ApplicationRecord
  belongs_to :user

  mount_uploader :avatar, RoomAvatarUploader
end
