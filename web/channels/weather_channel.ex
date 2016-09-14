defmodule Anka.WeatherChannel do
  use Phoenix.Channel

  def join("weather:temp", _message, socket) do
    temp = Anka.WeatherData.get_temp(Anka.WeatherData)
    {:ok, temp, socket}
  end
end
