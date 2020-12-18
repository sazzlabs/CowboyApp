defmodule CowboyApp.Endpoint do
  @moduledoc "just a tiny plug"

  use Plug.Router

  plug(Plug.Logger)

  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)

  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "Hello World!")
  end

  get "/users" do
    users = [
      %{
        Felipe: %{age: 12, email: "felipe@gmail.com"},
        Joao: %{age: 21, email: "joao@gmail.com"},
        Pedro: %{age: 15, email: "pedro@gmail.com"},
        Julia: %{age: 25, email: "julia@gmail.com"}
      }
    ]

    send_resp(conn, 200, Poison.encode!(%{users: users}))
  end
end
