import { Socket } from "phoenix"

export default class HangwebSocket {
    constructor() {
        this.socket = new Socket("/socket", {connect: "please"})
        this.socket.connect()
        console.log("Socket connected!")
    }

    connect_to_hangman() {
        this.setup_channel()
        this.channel.on("tally", tally => {
            console.log("Received tally!");
            console.dir(tally)
        });
    }

    setup_channel() {
        this.channel = this.socket.channel("hangman:game", {foo: "bar"})
        this.channel.join()
        .receive("ok", resp => {
            console.log("Channel joined: " + resp)
            this.fetch_tally()
        })
        .receive("error", resp => {
            alert(resp)
            throw(resp)
        })
    }

    fetch_tally() {
        this.channel.push("tally", {})
    }
}