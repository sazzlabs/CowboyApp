defmodule CowboyApp.UsersController do
  import Plug.Conn

  def index(conn) do
    users = [
      %{
        Felipe: %{age: 12, email: "felipe@gmail.com"},
        Joao: %{age: 21, email: "joao@gmail.com"},
        Pedro: %{age: 15, email: "pedro@gmail.com"},
        Julia: %{age: 25, email: "julia@gmail.com"}
      }
    ]

    send_resp(conn, 200, Jason.encode!(%{"users" => users}))
  end
end
