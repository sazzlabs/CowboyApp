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

  get "/animethemes" do
    case HTTPoison.get("https://staging.animethemes.moe/api/theme/3261") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        decoded_body = Jason.decode!(body)
        entries = List.first(decoded_body["entries"])
        staging_link = List.first(entries["videos"])["link"]

        production_link =
          String.replace(staging_link, "v.staging.animethemes.moe", "animethemes.moe/video")

        send_resp(
          conn,
          200,
          Jason.encode!(%{
            "title" => decoded_body["anime"]["name"],
            "season" => decoded_body["anime"]["season"],
            "year" => decoded_body["anime"]["year"],
            "type" => decoded_body["type"],
            "song" => %{
              "title" => decoded_body["song"]["title"],
              "artists" => decoded_body["song"]["artists"]
            },
            "link" => production_link
          })
        )

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        send_resp(conn, 404, Jason.encode!(%{"message" => "Not Found", "code" => 404}))

      {:error, %HTTPoison.Error{reason: reason}} ->
        send_resp(
          conn,
          500,
          Jason.encode(%{"message" => "Internal Server Error", "code" => 500, "reason" => reason})
        )
    end
  end
end
