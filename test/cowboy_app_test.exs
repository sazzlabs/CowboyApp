defmodule CowboyAppTest do
  use ExUnit.Case, async: true
  doctest CowboyApp

  use Plug.Test
  @opts CowboyApp.Endpoint.init([])

  test "it returns hello world" do
    conn = conn(:get, "/")

    conn = CowboyApp.Endpoint.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "Hello World!"
  end
end
