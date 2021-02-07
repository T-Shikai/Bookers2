class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, {only:[:destroy]}

  def ensure_correct_user
    if current_user != Message.find(params[:id]).user
      redirect_back(fallback_location: user_path(current_user))
    end
  end

  def create
    if UserRoom.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      message = Message.new(params.require(:message).permit(:user_id, :content, :room_id).merge(user_id: current_user.id))
      @room = Room.find_by(id: message.room_id)
      @messages = Message.where(room_id: @room.id)
      @message = Message.new
      if message.save
        render :index
      end
    else
      redirect_back(fallback_location: user_path(current_user))
    end
  end

  def destroy
    message = Message.find(params[:id])
    @room = Room.find_by(id: message.room_id)
    @messages = Message.where(room_id: @room.id)
    @message = Message.new
    if message.delete
      render :index
    end
  end
end
