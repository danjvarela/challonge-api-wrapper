require "rails_helper"
require "support/contexts/setup_tournament"

RSpec.shared_examples "a successful response" do
  context "status" do
    it { expect(response.status).to eq 200 }
  end

  context "body" do
    it { expect(formatted_body).to be_an_instance_of(Challonge::Resource).or(be_an_instance_of(Array)) }
    it { expect(formatted_body).not_to respond_to(:errors) }
  end
end

RSpec.shared_examples "a failed response" do
  context "status" do
    it "should not start with 2" do
      expect(response.status.to_s.match?(/^2\d{2}$/)).not_to eq 2
    end
  end

  context "body" do
    it { expect(formatted_body).to respond_to(:errors) }
  end
end

RSpec.describe "V1::Tournaments", type: :request do
  describe "GET /index" do
    include_context "setup tournament"
    it_behaves_like "a successful response" do
      before(:all) { get v1_tournaments_path }
    end
  end

  describe "POST /create" do
    context "when params are valid" do
      it_behaves_like "a successful response" do
        before(:all) { post v1_tournaments_path, params: {name: random_name} }
      end
    end

    context "when params are invalid" do
      it_behaves_like "a failed response" do
        before(:all) { post v1_tournaments_path, params: {name: nil} }
      end
    end
  end

  describe "PUT /update" do
    include_context "setup tournament"

    context "when params are valid and the tournament exists" do
      it_behaves_like "a successful response" do
        before(:all) { put v1_tournament_path(id: @created_tournament_id), params: {name: random_name} }
      end
    end

    context "when params are invalid" do
      it_behaves_like "a failed response" do
        before(:all) { put v1_tournament_path(id: @created_tournament_id), params: {name: nil} }
      end
    end

    context "when tournament does not exist" do
      it_behaves_like "a failed response" do
        before(:all) { put v1_tournament_path(id: random_name), params: {name: random_name} }
      end
    end
  end

  describe "GET /show" do
    context "when the tournament exists" do
      include_context "setup tournament"
      it_behaves_like "a successful response" do
        before(:all) { get v1_tournament_path(id: @created_tournament_id) }
      end
    end

    context "when the tournament does not exist" do
      it_behaves_like "a failed response" do
        before(:all) { get v1_tournament_path(id: random_name) }
      end
    end
  end

  describe "DELETE /destroy" do
    context "when the tournament exists" do
      include_context "setup tournament"
      it_behaves_like "a successful response" do
        before(:all) { delete v1_tournament_path(id: @created_tournament_id) }
      end
    end

    context "when the tournament does not exist" do
      it_behaves_like "a failed response" do
        before(:all) { delete v1_tournament_path(id: random_name) }
      end
    end
  end
end
