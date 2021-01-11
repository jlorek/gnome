```
:observer.start()
```

```
MFA = Module Function Argument
eg. spawn_link(Chain, :message_loop, [])
```

```
# dump own message queue
iex> flush
```

```
Maps also support a specific update syntax to update the value stored
under existing atom keys:

    iex> map = %{one: 1, two: 2}
    iex> %{map | one: "one"}
    %{one: "one", two: 2}

When a key that does not exist in the map is updated a KeyError
exception will be raised:

    %{map | three: 3}
```


```
#iex:break
```

```
iex(6)> [{:path, "path"}]
[path: "path"]
iex(7)> {:path, "path"}
{:path, "path"}
iex(8)> {:dictionary, {:path, "path"}}
{:dictionary, {:path, "path"}}
iex(9)> {:dictionary, path: "path"}
{:dictionary, [path: "path"]}
iex(10)> {:dictionary, path: "path", foo: "bar"}
{:dictionary, [path: "path", foo: "bar"]}
iex(11)> {:dictionary, path: "path", foo: "bar"}
{:dictionary, [path: "path", foo: "bar"]}
iex(12)> {:dictionary, path: "path", foo: "bar"}
{:dictionary, [path: "path", foo: "bar"]}
iex(13)> {_, list} = {:dictionary, path: "path", foo: "bar"}
{:dictionary, [path: "path", foo: "bar"]}
iex(14)> list
[path: "path", foo: "bar"]
iex(15)> list = [{:path, "path"}, {:foo, "bar"}]
[path: "path", foo: "bar"]
iex(16)> list == [{:path, "path"}, {:foo, "bar"}]
true
iex(17)> {_, list} = {:dictionary, path: "path", foo: "bar"}
{:dictionary, [path: "path", foo: "bar"]}
iex(18)>
nil
iex(19)> {_, list} = {:dictionary, path: "path", foo: "bar"}
{:dictionary, [path: "path", foo: "bar"]}
iex(20)> list
[path: "path", foo: "bar"]
iex(21)> list == [{:path, "path"}, {:foo, "bar"}]
true
```