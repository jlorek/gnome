// alert("foo")

import HangwebSocket from "./hangweb_socket.js"

window.onload = function() {
    let hangman = new HangwebSocket()
    hangman.connect_to_hangman()
}