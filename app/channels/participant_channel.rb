class ParticipantChannel < ApplicationCable::Channel
  def subscribed
    stream_from "participant"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
