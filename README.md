```
# start server (correct sname is important)
cd hangman
mix --sname hangman -S mix

# start clients
cd text_client
mix --sname client1 -S mix
TextClient.start
TextClient.start_ai
```