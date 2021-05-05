class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: %i[ show edit update destroy add_participant destroy_participant ]
  before_action :set_rooms, only: %i[ show index ]
  before_action :set_user, only: %i[ add_participant destroy_participant ]

  def index
  end

  def create
    @room = Room.new(room_params)
    @room.user = current_user
    @room.save
    redirect_to room_path(@room)
  end

  def add_participant
    if @room.participants.where(user_id: @user.id).first
      flash[:alert] = "#{@user.username} is already a participant of #{@room.name}"
    else
      if @user.friends_with?(current_user)
        flash[:notice] = "You added #{@user.username} as a participant to #{@room.name}"
        Participant.create(user_id: @user.id, room_id: @room.id)
      else
        flash[:alert] = "An error has occurred"
      end
    end
    
    redirect_to room_path(@room)
  end

  def destroy_participant
    if @room.participants.where(user_id: @user.id).first
      participant = Participant.where(user_id: @user.id, room_id: @room.id).first

      if @room.user.eql?(@user)
        flash[:alert] = "An error has occurred"
      else  
        if participant
          participant.delete
          flash[:notice] = "You removed #{@user.username} as a participant from #{@room.name}"
        else
          flash[:alert] = "An error has occurred"
        end
      end
    else
      flash[:alert] = "An error has occurred"
    end

    redirect_to room_path(@room)
  end

  def show
    render :index
  end

  private
    def set_room
      @room = current_user.rooms.find(params[:id])
    end

    def set_rooms
      @rooms = current_user.rooms
    end

    def set_user
      @user = User.friendly.find(params[:user_id])
    end

    def room_params
      params.require(:room).permit(:name, :avatar)
    end
end
