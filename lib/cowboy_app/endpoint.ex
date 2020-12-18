defmodule CowboyApp.Endpoint do
  @moduledoc "just a tiny plug"

  use Plug.Router

  plug(Plug.Logger)

  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Jason)

  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "Hello World!")
  end

  get "/users" do
    CowboyApp.UsersController.index(conn)
  end

  get "/animethemes" do
    CowboyApp.AnimeThemesController.index(conn)
  end

  get "/animethemes/random" do
    CowboyApp.AnimeThemesController.random(conn)
  end
end
