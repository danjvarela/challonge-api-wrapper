require "rails_helper"

RSpec.describe "V1::Tournaments", type: :request do
  describe "POST /v1/tournaments" do
    context "with valid params" do
      before :all do
        post v1_tournaments_path(tournament: {name: random_name})
        @created_tournament_response_id = json_body["tournament"]["id"]
      end

      after :all do
        Challonge::Tournament.destroy(@created_tournament_response_id)
      end

      context "response" do
        subject { response }
        it { is_expected.to have_http_status(200) }

        context "body" do
          subject { json_body }
          it { is_expected.to have_key("tournament") }
        end
      end
    end

    context "with invalid params" do
      before :all do
        post v1_tournaments_path, params: {tournament: {name: ""}}
      end

      context "response" do
        subject { response }
        it { expect(response.status).to be >= 400 }

        context "body" do
          subject { json_body }
          it { is_expected.to have_key("errors") }
        end
      end
    end
  end

  describe "GET /v1/tournaments" do
    before :all do
      @created_tournament_response = Challonge::Tournament.create(tournament: {name: random_name})
      @created_tournament_response_id = @created_tournament_response.body.tournament.id
      get v1_tournaments_path
    end

    after :all do
      Challonge::Tournament.destroy(@created_tournament_response_id)
    end

    context "response" do
      subject { response }
      it { is_expected.to have_http_status(200) }

      context "body" do
        subject { json_body }
        it { is_expected.to be_an_instance_of(Array) }

        context "elements" do
          subject { json_body.first }
          it { is_expected.to have_key("tournament") }
        end
      end
    end
  end

  describe "GET /v1/tournaments/:id" do
    context "when id exists" do
      before :all do
        @created_tournament_response = Challonge::Tournament.create(tournament: {name: random_name})
        @created_tournament_response_id = @created_tournament_response.body.tournament.id
        get v1_tournament_path(id: @created_tournament_response_id)
      end

      after :all do
        Challonge::Tournament.destroy(@created_tournament_response_id)
      end

      context "response" do
        subject { response }
        it { is_expected.to have_http_status(200) }

        context "body" do
          subject { json_body }
          it { is_expected.to have_key("tournament") }
        end
      end
    end

    context "when id does not exist" do
      before :all do
        get v1_tournament_path(id: long_id)
      end
      context "response" do
        subject { response }
        it { expect(response.status).to be >= 400 }

        context "body" do
          subject { json_body }
          it { is_expected.to have_key("errors") }
        end
      end
    end
  end

  describe "DELETE v1/tournaments/:id" do
    context "when id exists" do
      before :all do
        @created_tournament_response = Challonge::Tournament.create(tournament: {name: random_name})
        @created_tournament_response_id = @created_tournament_response.body.tournament.id
        delete v1_tournament_path(id: @created_tournament_response_id)
      end

      context "response" do
        subject { response }
        it { is_expected.to have_http_status(200) }

        context "body" do
          subject { json_body }
          it { is_expected.to have_key("tournament") }
        end
      end
    end

    context "when id does not exist" do
      before :all do
        delete v1_tournament_path(id: long_id)
      end

      context "response" do
        subject { response }
        it { expect(response.status).to be >= 400 }

        context "body" do
          subject { json_body }
          it { is_expected.to have_key("errors") }
        end
      end
    end
  end
end
