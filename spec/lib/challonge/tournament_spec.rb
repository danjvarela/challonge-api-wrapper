RSpec.describe Challonge::Tournament do
  before :all do
    @created_tournament = Challonge::Tournament.create({tournament: {name: random_name}})
  end

  describe ".all" do
    before :all do
      @response = Challonge::Tournament.all
    end

    context ".body" do
      subject { @response.body }
      it { is_expected.to be_an_instance_of(Array) }
    end

    context ".status" do
      subject { @response.status }
      it { is_expected.to eq 200 }
    end
  end

  describe ".create" do
    before :all do
      @success_response = @created_tournament
      @error_response = Challonge::Tournament.create
    end

    context "with valid params" do
      context ".body" do
        subject { @success_response.body }
        it { expect(subject.keys).to include(:tournament) }
      end
      context ".status" do
        subject { @success_response.status }
        it { is_expected.to eq 200 }
      end
    end

    context "with invalid params" do
      context ".body" do
        subject { @error_response.body }
        it { expect(subject.keys).to include(:errors) }
      end
      context ".status" do
        subject { @error_response.status }
        it { is_expected.to be >= 400 }
      end
    end
  end

  describe ".show" do
    before :all do
      id = @created_tournament.body.tournament.id
      @success_response = Challonge::Tournament.show(id)
      @error_response = Challonge::Tournament.show(
        "alskdjalskdjalskdjajdksfjlggwoeirulkj23l4j345934lkjfalksjdnlakjlqkjflaksjdlaksjdlaksjdqrjjlkjdlaksjd"
      )
    end

    context "with valid params" do
      context ".body" do
        subject { @success_response.body }
        it { expect(subject.keys).to include(:tournament) }
      end
      context ".status" do
        subject { @success_response.status }
        it { is_expected.to eq 200 }
      end
    end

    context "with invalid params" do
      context ".body" do
        subject { @error_response.body }
        it { expect(subject.keys).to include(:errors) }
      end
      context ".status" do
        subject { @error_response.status }
        it { is_expected.to be >= 400 }
      end
    end
  end
end
