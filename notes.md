```
:observer.start()
```

```
MFA = Module Function Argument
eg. spawn_link(Chain, :message_loop, [])
```

```
# Options List Syntax
iex(3)> x = fn x,y -> x == y end
#Function<43.97283095/2 in :erl_eval.expr/5>
iex(4)> x.(1,1)
true
iex(5)> x.(1,2)
false
iex(7)> x.([{:a, "a"}], a: "a")
true
iex(9)> x.([{:a, "a"}], a: "a", b: "b")
false
iex(10)> x.([{:a, "a"}, {:b, "b"}], a: "a", b: "b")
true
iex(11)>
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