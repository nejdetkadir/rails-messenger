import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {
  
   if (document.body.contains(document.getElementById('room-id'))) {
    const room_element = document.getElementById('room-id')
    const room_id = room_element.getAttribute('data-room-id')
    const user_id = room_element.getAttribute('data-user-id')

    consumer.subscriptions.subscriptions.forEach((subscription) => {
      consumer.subscriptions.remove(subscription)
    })

    consumer.subscriptions.create({ channel: "RoomChannel", room_id: room_id }, {
      connected() {
        //console.log("connected to " + room_id)
        scroll_bottom()
        // Called when the subscription is ready for use on the server
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        let html 

        if (data.user_id == user_id) {
          html = data.mine
          document.querySelector('form.container').reset() //clear textarea
        } else {
          html = data.theirs
        }

        let messages = document.querySelector('.messages')
        messages.innerHTML += html

        scroll_bottom()
        
        document.querySelectorAll('img[dataid]').forEach(item => {
          item.addEventListener('load', () => {
            scroll_bottom()
          })
        })
      }
    })

    function scroll_bottom() {
      document.querySelector(".col-9").scrollTo({ top: ( document.querySelector(".col-9").scrollHeight + 1000), behavior: 'auto' })
    }
   }
})