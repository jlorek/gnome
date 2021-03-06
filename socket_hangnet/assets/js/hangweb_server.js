import { Socket } from "phoenix"

export default class HangwebServer {
    constructor(tally, timer) {
        this.tally = tally
        this.timer = timer
        this.socket = new Socket("/socket", {connect: "please"})
        this.socket.connect()
        console.log("Socket connected!")
    }

    connect_to_hangman() {
        this.setup_channel()
        this.channel
            .join()
            .receive("ok", resp => {
                console.log("Channel joined: ", resp)
                this.fetch_tally()
            })
            .receive("error", resp => {
                alert("No Socket - no fun! Error: " + resp)
                throw(resp)
            })
    }

    setup_channel() {
        this.channel = this.socket.channel("hangman:game", {foo: "bar"})
        this.channel.on("tally", tally => {
            console.log("Received tally: ", tally)
            this.copy_tally(tally)
        })
        this.channel.on("timer", timer => {
            console.log("Received timer: ", timer)
            this.copy_timer(timer)
        })
    }

    fetch_tally() {
        this.channel.push("tally", {})
    }

    make_move(guess) {
        this.channel.push("make_move", guess)
    }

    new_game() {
        this.channel.push("new_game", {})
    }

    copy_tally(from) {
        for (let k in from) {
            this.tally[k] = from[k]
        }
    }
    
    copy_timer(from) {
        for (let k in from) {
            this.timer[k] = from[k]
        }
    }
}