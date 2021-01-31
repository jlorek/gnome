defmodule SocketHangnetWeb.PageController do
  use SocketHangnetWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
