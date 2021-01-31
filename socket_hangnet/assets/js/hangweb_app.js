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

let view = function(hangman, timer) {
    let app = new Vue({
        el: "#app",
        data: {
            tally: hangman.tally,
            timer: hangman.timer
        },
        created() {
            const component = this;
            this.handler = function (e) {
                component.guess(e.key)
            }
            window.addEventListener('keyup', this.handler)
        },
        beforeDestroy() {
            window.removeEventListener('keyup', this.handler)
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
    let tally = {
        turns_left: 7,
        letters: ["l", "o", "a", "d", "i", "n", "g"],
        game_state: "initializing",
        used: [ ]
    }
    let timer = {
        total_seconds: 0
    }
    let hangman = new HangwebServer(tally, timer)
    let app = view(hangman)
    hangman.connect_to_hangman()
}