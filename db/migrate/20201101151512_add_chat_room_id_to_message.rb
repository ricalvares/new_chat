class AddChatRoomIdToMessage < ActiveRecord::Migration[6.0]
  def change
    add_reference :messages, :chat_room, foreign_key: true, null: false
  end
end
