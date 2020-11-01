class ChatRoomController < ApplicationController
  def index
    @chat_rooms = ChatRoom.all
  end

  def new
    @chat_room = ChatRoom.new
  end

  def create
    @chat_room = ChatRoom.new(chat_room_params)
    respond_to do |format|
      if @chat_room.save
        format.html { redirect_to @chat_room, notice: 'Chat room was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def show
    @message = Message.new
    @messages = Message.all
    @chat_room = ChatRoom.find_by(id: params[:id])
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title)
  end
end
