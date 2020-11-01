import consumer from "./consumer"

consumer.subscriptions.create("ChatRoomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("ChatRoom connected!");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const msg = data.message
    $(`.msgs-chat-room-${msg.room_id} > tbody`).append(
      `<tr>
        <td>${msg.content}</td>
        <td>${msg.creator}</td>
        <td>${msg.created_at}</td>
      </tr>`
    )
  }
});
