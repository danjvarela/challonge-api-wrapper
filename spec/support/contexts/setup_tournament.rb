RSpec.shared_context "setup tournament" do
  before :all do
    @create_response = Challonge::Tournament.create name: random_name
    @created_tournament_id = @create_response.body.id
  end

  after :all do
    Challonge::Tournament.destroy @created_tournament_id
  end
end
