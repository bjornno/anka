defmodule Anka.WeatherData do
  require Logger
  @appid "eab7a29606869161391061174665cefc"
  @httpc :httpc
  
  def start_link(name) do
    {:ok, pid} = result = Agent.start_link(fn -> nil end, name: name)
    update_temperature(pid, "Stockholm")
    result
  end

  def get_temp(pid) do
    Agent.get(pid, fn(state) -> state end)
  end

  def update_temperature(pid, place) do
    Agent.update(pid, fn(_) -> download_temperature(place) end)
  end

  def download_temperature(place) do
    {:ok, {{_, 200, _}, _, body}} = @httpc.request(String.to_char_list("http://api.openweathermap.org/data/2.5/weather?q=#{place}&appid=#{@appid}"))
    %{"main" => %{"temp" => temp}} = Poison.decode!(body)
    Logger.info("temperature (kelvin) #{inspect temp}")
    temp - 273.15
  end
end
