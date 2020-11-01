class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    CreateMessageJob.perform_later(
      content: message_params[:content],
      user_id: message_params[:user_id],
      chat_room_id: message_params[:chat_room_id]
    )
  end

  private

  def message_params
    params.require(:message).permit(:content, :user_id, :chat_room_id)
  end
end
