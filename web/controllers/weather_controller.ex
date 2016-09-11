defmodule Anka.WeatherController do
  use Anka.Web, :controller
  require Logger

  @appid "eab7a29606869161391061174665cefc"

  def index(conn, _params) do
   render conn, [temp: 23.5]
  end

  def create(conn, _param) do
    #{:ok, %HTTPoison.Response{status_code: 200, body: body}} = HTTPoison.get("http://api.openweathermap.org/data/2.#5/weather?q=Stockholm&appid=#{@appid}")
    #%{"main" => %{"temp" => temp}} = Poison.decode!(body)
    #Logger.info("temperature (kelvin) #{inspect temp}")
    #Anka.Endpoint.broadcast "weather:temp", "new_temp", %{temp: temp - 273.15}
    Anka.Endpoint.broadcast "weather:temp", "new_temp", %{temp: inspect _param}
    render conn, []
  end
end
