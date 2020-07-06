module Helpers
  def response_json_body
    JSON.parse(response.body)
  end
end
