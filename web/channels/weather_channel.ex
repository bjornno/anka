defmodule Anka.WeatherChannel do
  use Phoenix.Channel

  def join("weather:temp", _message, socket) do    
    {:ok, socket}
  end
end
