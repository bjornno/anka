defmodule Anka.WeatherController do
  use Anka.Web, :controller

  def index(conn, _params) do
   render conn, temp: 23.5 
  end
end
