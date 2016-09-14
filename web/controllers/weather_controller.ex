defmodule Anka.WeatherController do
  use Anka.Web, :controller
  require Logger

  def index(conn, _params) do
    temp = Anka.WeatherData.get_temp(Anka.WeatherData)
    Anka.Endpoint.broadcast "weather:temp", "new_temp", %{temp: temp}
    render conn, [temp: temp]
  end

  def create(conn, _param) do
    %{"actorId" => _, "created" => _, "data" => %{"created" => _, "id" => message_id, "personEmail" => sender_email, "personId" => _, "roomId" => _, "roomType" => _}, "event" => "created", "id" => _, "name" => "anka", "resource" => "messages", "targetUrl" => "https://fast-stream-59170.herokuapp.com/api/weather"} = _param

    unless sender_email == "kalle@sparkbot.io" do
      query = Anka.Spark.evaluate(message_id)
      luis_result = Anka.Luis.evaluate(query)
      case luis_result do
        ["weather", place] -> 
          Anka.WeatherData.update_temperature(Anka.WeatherData, place)
          temp = Anka.WeatherData.get_temp(Anka.WeatherData)
          Anka.Endpoint.broadcast "weather:temp", "new_temp", %{temp: "temperature in #{place} is: #{temp} asked by #{sender_email}"}
        false ->
          Anka.Endpoint.broadcast "weather:temp", "new_temp", %{temp: "did not understand the question"}
      end

    end
    render conn, []
  end

  

end
