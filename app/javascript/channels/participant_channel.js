import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {

  if (document.body.contains(document.getElementById('room'))) {
    consumer.subscriptions.create("ParticipantChannel", {
      connected() {
        // Called when the subscription is ready for use on the server
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        if (document.getElementById('room').getAttribute('data-user-id') == data.id) {
          document.querySelector('.col-3').innerHTML += data.html
        }
        // Called when there's incoming data on the websocket for this channel
      }
    })
  }
})
