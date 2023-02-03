require "rails_helper"

RSpec.describe Challonge::Client do
  describe ".new" do
    subject { Challonge::Client }
    it { expect(subject.to_s).to eq Challonge::BASE_URL }
  end
end
