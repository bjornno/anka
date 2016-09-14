defmodule Anka.WeatherController do
  use Anka.Web, :controller
  require Logger

  def index(conn, _params) do
    temp = Anka.WeatherData.get_temp(Anka.WeatherData)
    Anka.Endpoint.broadcast "weather:temp", "new_temp", %{temp: temp}
    render conn, [temp: temp]
  end

  def create(conn, _param) do
    Anka.WeatherData.update_temperature(Anka.WeatherData)
    render conn, []
  end
end
