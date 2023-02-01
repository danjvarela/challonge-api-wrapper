require "rails_helper"

RSpec.describe Challonge::Tournament do
  include ParamsHelpers

  describe ".destroy" do
    context "when tournament id or url exists" do
      let(:delete_tournament_response) do
        id = Challonge::Tournament.create({tournament: {name: random_name}}).body.tournament.id
        Challonge::Tournament.destroy(id)
      end

      context ".body" do
        subject { delete_tournament_response.body }
        it { is_expected.to have_key(:tournament) }
      end

      context ".status" do
        subject { delete_tournament_response.status }
        it { is_expected.to eq 200 }
      end
    end

    context "when tournament id or url does not exist" do
      let(:delete_tournament_response) do
        Challonge::Tournament.destroy(long_id)
      end

      context ".body" do
        subject { delete_tournament_response.body }
        it { is_expected.to have_key(:errors) }
      end
      context ".status" do
        subject { delete_tournament_response.status }
        it { is_expected.to be >= 400 }
      end
    end
  end

  describe ".all" do
    before :all do
      @created_tournament_response = Challonge::Tournament.create(tournament: {name: random_name})
    end

    after :all do
      Challonge::Tournament.destroy(@created_tournament_response.body.tournament.id)
    end

    let(:all_tournaments_response) do
      Challonge::Tournament.all
    end

    context ".body" do
      subject { all_tournaments_response.body }
      it { is_expected.to be_an_instance_of(Array) }
    end

    context ".status" do
      subject { all_tournaments_response.status }
      it { is_expected.to eq 200 }
    end
  end

  describe ".create" do
    before :all do
      @created_tournament_response = Challonge::Tournament.create(tournament: {name: random_name})
    end

    after :all do
      Challonge::Tournament.destroy(@created_tournament_response.body.tournament.id)
    end

    let(:invalid_tournament_response) do
      Challonge::Tournament.create(tournament: {name: nil})
    end

    context "with valid params" do
      context ".body" do
        subject { @created_tournament_response.body }
        it { expect(subject.keys).to include(:tournament) }
      end
      context ".status" do
        subject { @created_tournament_response.status }
        it { is_expected.to eq 200 }
      end
    end

    context "with invalid params" do
      context ".body" do
        subject { invalid_tournament_response.body }
        it { expect(subject.keys).to include(:errors) }
      end
      context ".status" do
        subject { invalid_tournament_response.status }
        it { is_expected.to be >= 400 }
      end
    end
  end

  describe ".show" do
    before :all do
      @created_tournament_response = Challonge::Tournament.create(tournament: {name: random_name})
    end

    after :all do
      Challonge::Tournament.destroy(@created_tournament_response.body.tournament.id)
    end

    let(:non_existent_tournament_response) do
      Challonge::Tournament.show(long_id)
    end

    context "with valid params" do
      context ".body" do
        subject { @created_tournament_response.body }
        it { expect(subject.keys).to include(:tournament) }
      end
      context ".status" do
        subject { @created_tournament_response.status }
        it { is_expected.to eq 200 }
      end
    end

    context "with invalid params" do
      context ".body" do
        subject { non_existent_tournament_response.body }
        it { expect(subject.keys).to include(:errors) }
      end
      context ".status" do
        subject { non_existent_tournament_response.status }
        it { is_expected.to be >= 400 }
      end
    end
  end
end
