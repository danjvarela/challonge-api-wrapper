require "rails_helper"
require "support/contexts/setup_tournament"

RSpec.shared_examples "a hash or array with no errors" do
  subject { @resource }
  it { is_expected.to be_an_instance_of(Challonge::Resource).or(be_an_instance_of(Array)) }
  it { is_expected.not_to respond_to(:errors) }
end

RSpec.shared_examples "a hash with errors" do
  subject { @resource }
  it { is_expected.to be_an_instance_of(Challonge::Resource) }
  it { is_expected.to respond_to(:errors) }
end

RSpec.shared_examples "a failed response" do
  context ".status" do
    it "should not start with 2" do
      expect(@response.status.to_s.match?(/^2\d{2}$/)).not_to eq 2
    end
  end

  context ".body" do
    it_behaves_like "a hash with errors" do
      before(:all) { @resource = @response.body }
    end
  end
end

RSpec.shared_examples "a successful response" do
  context ".body" do
    it_behaves_like "a hash or array with no errors" do
      before(:all) { @resource = @response.body }
    end
  end

  context ".status" do
    it { expect(@response.status).to eq 200 }
  end
end

RSpec.describe Challonge::Tournament do
  context ".create" do
    context "with valid params" do
      include_context "setup tournament"
      it_behaves_like "a successful response" do
        before(:all) { @response = @create_response }
      end
    end

    context "with invalid params" do
      it_behaves_like "a failed response" do
        before(:all) { @response = Challonge::Tournament.create name: nil }
      end
    end
  end

  context ".all" do
    include_context "setup tournament"
    it_behaves_like "a successful response" do
      before(:all) { @response = Challonge::Tournament.all }
    end
  end

  context ".find" do
    context "when tournament exists" do
      include_context "setup tournament"
      it_behaves_like "a successful response" do
        before(:all) { @response = Challonge::Tournament.find(@created_tournament_id) }
      end
    end

    context "when tournament does not exist" do
      it_behaves_like "a failed response" do
        before(:all) { @response = Challonge::Tournament.find(random_name) }
      end
    end
  end

  context ".destroy" do
    context "when tournament exists" do
      include_context "setup tournament"
      it_behaves_like "a successful response" do
        before(:all) { @response = Challonge::Tournament.destroy(@created_tournament_id) }
      end
    end

    context "when tournament does not exist" do
      it_behaves_like "a failed response" do
        before(:all) { @response = Challonge::Tournament.destroy(random_name) }
      end
    end
  end

  context ".update" do
    context "when the tournament exists and the params invalid" do
      include_context "setup tournament"
      it_behaves_like "a successful response" do
        before(:all) { @response = Challonge::Tournament.update(@created_tournament_id, name: random_name) }
      end
    end

    context "when the tournament does not exist" do
      it_behaves_like "a failed response" do
        before(:all) { @response = Challonge::Tournament.update(random_name, name: random_name) }
      end
    end

    context "when the params are invalid" do
      include_context "setup tournament"
      it_behaves_like "a failed response" do
        before(:all) { @response = Challonge::Tournament.update(@created_tournament_id, name: nil) }
      end
    end
  end
end
