// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "bootstrap/dist/js/bootstrap.bundle"
global.toastr = require("toastr")

document.addEventListener('turbolinks:load', () => {
  if (document.body.contains(document.getElementById('message_content'))) {
    document.getElementById("message_content").addEventListener('keyup', checkInput)

    document.querySelector("form.container").addEventListener('submit', () => {
      document.getElementById("send-msg-btn").disabled = true
    })

    document.getElementById("file-btn").addEventListener('click', () => {
      document.getElementById("message_image").click()
    })

    document.getElementById("message_image").addEventListener('change', (e) => {
      if (e.target.files.length < 1) {
        document.getElementById("send-msg-btn").disabled = true
      } else {
        document.getElementById("send-msg-btn").disabled = false
      }
    })
  }

  function checkInput(e) {
    if (e.target.value.trim().length < 1) {
      document.getElementById("send-msg-btn").disabled = true
    } else {
      document.getElementById("send-msg-btn").disabled = false
    }
  }
})
