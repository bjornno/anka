defmodule Anka.WeatherController do
  use Anka.Web, :controller
  require Logger

  def index(conn, _params) do
    temp = Anka.WeatherData.get_temp(Anka.WeatherData)
    Anka.Endpoint.broadcast "weather:temp", "new_temp", %{temp: temp}
    render conn, [temp: temp]
  end

  def create(conn, _param) do
    %{"query" => query} = _param
    luis_result = Anka.Luis.evaluate(query)
    case luis_result do
      ["weather", place] -> 
        Anka.WeatherData.update_temperature(Anka.WeatherData, place)
        temp = Anka.WeatherData.get_temp(Anka.WeatherData)
        Anka.Endpoint.broadcast "weather:temp", "new_temp", %{temp: temp}
      false ->
        Anka.Endpoint.broadcast "weather:temp", "new_temp", %{temp: "did not understand the question"}
    end
    render conn, []
  end
end
