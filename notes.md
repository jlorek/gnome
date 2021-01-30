```
:observer.start()
```

```
# update nested structure
iex(9)> data = %{foo: %{bar: "baz"}}
%{foo: %{bar: "baz"}}
iex(10)> data.foo
%{bar: "baz"}
iex(11)> data.foo.bar
"baz"
iex(12)> data.foo.bar = "knarz"
** (CompileError) iex:12: cannot invoke remote function data.foo/0 inside a match
iex(12)> data = put_in(data.foo.bar, "knarz")
%{foo: %{bar: "knarz"}}
```

```
iex(5)> i"foo"
Term
  "foo"
Data type
  BitString
Byte size
  3
Description
  This is a string: a UTF-8 encoded binary. It's printed surrounded by
  "double quotes" because all UTF-8 encoded code points in it are printable.
Raw representation
  <<102, 111, 111>>
Reference modules
  String, :binary
Implemented protocols
  Collectable, IEx.Info, Inspect, List.Chars, String.Chars
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