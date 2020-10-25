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
    console.log(data)
    debugger
    $(`.msgs-chat-room-${data.room_id} > tbody`).append(
      `<tr>
        <td>${data.message}</td>
        <td>${data.creator}</td>
      </tr>`
      )
    console.log("Recieving:")
    console.log(data)
  }
});

let submit_messages;
$(document).on('turbolinks:load', function () {
  submit_messages()
})

submit_messages = function () {
  $('#message_content').on('keydown', function (event) {
    if (event.keyCode == 13) {
      $('input').click()
      event.target.value = ''
      event.preventDefault()
    }
  })
}