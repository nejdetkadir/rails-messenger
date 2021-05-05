class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
  mount_uploader :image, MessageUploader
end
