class RoomsController < ApplicationController
  before_action :set_room, only: %i[update destroy show]

  def index
    @room = Room.new
    @rooms = Room.public_room
    @users = User.all_except(current_user)
    render 'index'
  end

  def show
    @current_user = current_user
    @single_room = @room
    @message = Message.new
    @messages = @single_room.messages.order(created_at: :asc)
    @rooms = Room.public_room
    @users = User.all_except(current_user)
    render 'index'
  end

  def create
    @room = Room.create(set_params)
  end

  def update
    if @room.update(set_params)
      flash.now[:notice] = 'succes'
      redirect_to rooms_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy; end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def set_params
    params.require(:room).permit(:name, :is_private)
  end
end
