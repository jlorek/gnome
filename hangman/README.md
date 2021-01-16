# Hangman

## How all this stuff works together

`mix.exs` kicks of `Hangman.Application`, which starts a Supervisor named `Hangman.Supervisor`. Each child/worker in this supervisor is a `Hangman.Server`. Each server instance holds the state of one game instance. The 

`Hangman` (the API) tells the `Hangman.Supervisor` to start a new child and returns the `pid` required for further API calls to `make_move` and  `tally`, which forward the calls to the corresponding methods in `Hangman.Game`.