require "rails_helper"

RSpec.describe Challonge::Client do
  describe ".new" do
    context ".url_prefix" do
      subject { Challonge::Client.new.url_prefix }
      it { expect(subject.to_s).to eq Challonge::BASE_URL }
    end
  end
end
