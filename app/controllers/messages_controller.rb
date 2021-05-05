class MessagesController < ApplicationController
  
  def create
    @message = Message.new(message_params)
    @message.user = current_user

    if !@message.save
      flash[:alert] = "#{@message.errors.full_messages.first}"
    end

    redirect_to room_path(@message.room)
  end

  private
    def message_params
      params.require(:message).permit(:content, :image, :room_id)
    end
end
