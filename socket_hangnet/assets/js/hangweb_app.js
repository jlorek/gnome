// alert("foo")

const RESPONSES = {
    won: ["info", "You won! 🎉"],
    lost: ["danger", "You lost... 😯"],
    good_guess: ["info", "Good guess! 🤓"],
    bad_guess: ["warning", "Bad guess! 😦"],
    invalid_guess: ["danger", "Invalid guess 🥴"],
    already_used: ["info", "You already guessed that 😉"],
    initializing: ["info", "Let's go! 🤙"]
}

let Vue = require("vue/dist/vue.min.js")
// import HangwebSocket from "./hangweb_socket.js"
import HangwebServer from "./hangweb_server"

let view = function(hangman) {
    let app = new Vue({
        el: "#app",
        data: {
            tally: hangman.tally
        },
        computed: {
            game_over: function() {
                let state = this.tally.game_state
                return (state == "won" || state == "lost")
            },
            game_state_message: function() {
                let state = this.tally.game_state
                return RESPONSES[state][1]
            },
            game_state_class: function() {
                let state = this.tally.game_state
                return RESPONSES[state][0]
            },
        },
        methods: {
            guess: function(ch) {
                hangman.make_move(ch)
            },
            new_game: function() {
                hangman.new_game()
            },
            already_guessed: function(ch) {
                return this.tally.used.indexOf(ch) >= 0
            },
            correct_guess: function(ch) {
                return this.already_guessed(ch) &&
                    (this.tally.letters.indexOf(ch) >= 0)
            },
            turns_gt: function(left) {
                return this.tally.turns_left > left
            }
        }
    })
    return app
}

window.onload = function() {
    // let hangman = new HangwebSocket()
    // hangman.connect_to_hangman()
    let tally = {
        turns_left: 7,
        letters: ["a", "_", "c"],
        game_state: "initializing",
        used: [ ]
    }
    let hangman = new HangwebServer(tally)
    let app = view(hangman)

    hangman.connect_to_hangman()
}