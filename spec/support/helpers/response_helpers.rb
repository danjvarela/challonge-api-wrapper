module ResponseHelpers
  def formatted_body
    json_body = JSON.parse(response.body)

    case json_body
    when Array
      json_body.map! { |element| Challonge::Resource.new element }
    when Hash
      Challonge::Resource.new json_body
    else
      Challonge::Resource.new
    end
  end
end
