defmodule Utils do
    def foo(t = {a,b}) do
        IO.puts "a = #{a}, b = #{b}, #{is_tuple(t)}"
    end

    # def swap({a,b}) do
    #     {b,a}
    # end

    def swap({a,b}), do: {b,a}

    def same({a,a}), do: true
    def same({_,_}), do: false

    def fib(0) do
        0
    end

    def fib(1) do
        1
    end

    def fib(n) do
        fib(n-1) + fib(n-2)
    end
end