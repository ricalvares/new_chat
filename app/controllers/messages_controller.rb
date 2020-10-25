class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    # CreateMessageJob.perform_later(
    #   content: message_params[:content],
    #   user_id: message_params[:user_id],
    #   chat_room_id: message_params[:chat_room_id]
    # )

    @message = Message.new(message_params.except(:chat_room_id))
    if @message.save
      data = {
        message: @message.content,
        creator: @message.user.name,
        room_id: 1
      }
      ActionCable.server.broadcast 'chat_rooom_channel', message: data
      ActionCable.server.broadcast 'room_channel', content: @message.content
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :user_id, :chat_room_id)
  end
end
