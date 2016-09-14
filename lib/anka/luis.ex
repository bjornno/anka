defmodule Anka.Luis do
	require Logger
	@app_id "eb6151ea-04c0-4b9f-ba68-e6010b7afd3a"
	@subscription_key "ecfc7b312edf4ff08d38aa5a6debf299"


  def evaluate(q) do
  	url = "https://api.projectoxford.ai/luis/v1/application?id=#{@app_id}&subscription-key=#{@subscription_key}&q=#{URI.encode(q)}"
    {:ok, {{_, 200, _}, _, body}} = :httpc.request(String.to_char_list(url))
    a = Poison.decode!(body)
  	case (a) do 	
  		%{
  			"query" => _,
  			"intents" => [%{"intent" => intentName, "score" => intentScore}| _],
				"entities" => [%{"endIndex" => _, "entity" => entityName, "score" => entityScore, "startIndex" => _, "type" => _}| _]
			} when intentScore > 0.7 and entityScore > 0.7 -> 
					[intentName, entityName]
				_ -> 
					false
	 	end
  end
end