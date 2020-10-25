class CreateMessageJob < ApplicationJob
  queue_as :create_message

  def perform(user_id: nil, content: nil, chat_room_id: nil)
    message = Message.create(content: content, user_id: user_id)
    data = {
      message: message.content,
      creator: message.user.name,
      room_id: chat_room_id
    }

    ActionCable.server.broadcast 'chat_rooom_channel', message: data
  end
end
