class CreateMessageJob < ApplicationJob
  queue_as :create_message

  def perform(user_id: nil, content: nil, chat_room_id: nil)
    user = User.find(user_id)
    chat_room = ChatRoom.find(chat_room_id)
    message = Message.create!(content: content, user_id: user.id, chat_room_id: chat_room.id)
    data = {
      content: message.content,
      creator: user.name,
      room_id: chat_room.id,
      created_at: message.created_at
    }
    ActionCable.server.broadcast 'chat_room_channel', data
  rescue ActiveRecord::RecordNotFound => e
    Rails.logger.error(">>>>>> #{e.message}")
  end
end
