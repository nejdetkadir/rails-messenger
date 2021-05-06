class CreateRoomJob < ApplicationJob
  queue_as :default

  def perform(participant)

    html = ApplicationController.render(
      partial: 'rooms/room',
      locals: { room: participant.room }
    )

    ActionCable.server.broadcast "participant", {id: participant.user_id, html: html}
  end
end
