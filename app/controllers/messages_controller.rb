class MessagesController < ApplicationController
  
  def create
    @message = Message.new(message_params)
    @message.user = current_user
    
    if @message.save
      SendMessageJob.perform_later(@message)
    end

    # if !@message.save
    #  flash[:alert] = "#{@message.errors.full_messages.first}"
    # end
  end

  private
    def message_params
      params.require(:message).permit(:content, :image, :room_id)
    end
end
