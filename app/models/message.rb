class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
  mount_uploader :image, MessageUploader

  #validates_presence_of :content, on: :create, message: "can not be blank"
end
