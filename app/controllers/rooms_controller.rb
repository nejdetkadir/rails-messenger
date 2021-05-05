class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: %i[ show destroy add_participant destroy_participant left_room ]
  before_action :set_rooms, only: %i[ show index ]
  before_action :set_user, only: %i[ add_participant destroy_participant left_room ]

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
          participant.destroy
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

  def left_room
    if @room.participants.where(user_id: current_user.id).first

      if @user.eql?(current_user)
        Participant.where(room_id: @room.id, user_id: current_user.id).first.destroy
        flash[:notice] = "You successfully left the #{@room.name}"
      else
        flash[:alert] = "An error has occurred"
      end
    else
      flash[:alert] = "An error has occurred"
    end

    redirect_to rooms_path
  end

  def show
    render :index
  end

  def destroy
    @room.destroy
    flash[:notice] = "You removed room successfully"
    redirect_to rooms_path
  end

  private
    def set_room
      @room = current_user.participants.where(room_id: params[:id]).first.room
    end

    def set_rooms
      @rooms = Array.new
      current_user.participants.each do |p|
        @rooms.push(p.room)
      end
    end

    def set_user
      @user = User.friendly.find(params[:user_id])
    end

    def room_params
      params.require(:room).permit(:name, :avatar)
    end
end
