defmodule GallowsWeb.PageController do
  use GallowsWeb, :controller

  def index(conn, _params) do
    # assigns can be a map or keyword list
    assigns = [say: "something", foo: "bar"]
    render(conn, "index.html", assigns)
  end
end
