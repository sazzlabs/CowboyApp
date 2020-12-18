defmodule CowboyAppTest do
  use ExUnit.Case
  doctest CowboyApp

  test "greets the world" do
    assert CowboyApp.hello() == :world
  end
end
