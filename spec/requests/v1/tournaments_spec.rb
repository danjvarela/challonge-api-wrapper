require "rails_helper"

RSpec.describe "V1::Tournaments", type: :request do
  describe "POST /v1/tournaments" do
    context "with valid params" do
      before :all do
        post v1_tournaments_path, params: {tournament: {name: random_name}}
      end

      subject { response }

      it { is_expected.to have_http_status(200) }

      context "response body" do
        subject { json_body }
        it { is_expected.to have_key("tournament") }
      end
    end

    context "with invalid params" do
      before :all do
        post v1_tournaments_path, params: {tournament: {name: ""}}
      end

      subject { response }

      it { expect(response.status).to be >= 400 }

      context "response body" do
        subject { json_body }
        it { is_expected.to have_key("errors") }
      end
    end
  end

  describe "GET /v1/tournaments" do
    before :all do
      get v1_tournaments_path
    end

    subject { response }

    it { is_expected.to have_http_status(200) }

    context "response body" do
      subject { json_body }
      it { is_expected.to be_an_instance_of(Array) }

      context "elements" do
        subject { json_body.first }
        it { is_expected.to have_key("tournament") }
      end
    end
  end

  describe "GET /v1/tournaments/:id" do
    context "when id exists" do
      before :all do
        id = Challonge::Tournament.create({tournament: {name: random_name}}).body["tournament"]["id"]
        get v1_tournament_path(id: id)
      end
      subject { response }

      it { is_expected.to have_http_status(200) }

      context "response body" do
        subject { json_body }
        it { is_expected.to have_key("tournament") }
      end
    end

    context "when id does not exist" do
      before :all do
        get v1_tournament_path(id: long_id)
      end

      subject { response }

      it { expect(response.status).to be >= 400 }

      context "response body" do
        subject { json_body }
        it { is_expected.to have_key("errors") }
      end
    end
  end
end
