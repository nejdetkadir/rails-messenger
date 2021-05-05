class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: %i[ show edit update destroy ]
  before_action :set_rooms, only: %i[ show index ]

  def index
  end

  def create
    @room = Room.new(room_params)
    @room.user = current_user
    @room.save
    redirect_to room_path(@room)
  end

  def show
    render :index
  end

  private
    def set_room
      @room = Room.find(params[:id])
    end

    def set_rooms
      @rooms = Room.all
    end

    def room_params
      params.require(:room).permit(:name, :avatar)
    end
end
