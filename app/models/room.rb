class Room < ApplicationRecord
  belongs_to :user

  has_many :participants, dependent: :destroy
  has_many :messages, dependent: :destroy

  mount_uploader :avatar, RoomAvatarUploader

  after_create :add_me_as_participant

  def add_me_as_participant
    p = Participant.new
    p.room = self
    p.user = self.user
    p.save
  end
end
