require 'spec_helper'
describe SearchEngine do
  let(:query) { "@jphenow" }
  subject { described_class.new query }

  it "calls twitter engine" do
    Twitter.should_receive(:search).once.and_return stub(statuses: [build(:status)])
    subject.search
  end
end
