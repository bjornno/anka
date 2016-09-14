defmodule Anka.Spark do
	require Logger

	def evaluate(message_id) do
    url = "https://api.ciscospark.com/v1/messages/#{message_id}"
    {:ok, {{_, 200, _}, _, body}} = :httpc.request(:get, {String.to_char_list(url), [{'Authorization', 'Bearer NmYxNTBlZTYtZjU4ZS00MTU2LTlkNWUtNzc3MjQ3MjQ5MjJlNjUyYTJhNDQtMWI1'}]}, [], [])
    
    decoded = Poison.decode!(body)

    %{"created" => _, "id" => _, "personEmail" => person_email, "personId" => _, "roomId" => _, "roomType" => _, "text" => query} = decoded
    query
  end
end
