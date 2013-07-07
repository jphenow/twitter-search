require 'spec_helper'
describe SearchEngine do
  let(:query) { "@jphenow" }
  let(:geo_options) { {} }
  subject { described_class.new query, geo_options }

  it "calls twitter engine" do
    Twitter
    .should_receive(:search)
    .once
    .with(query, {})
    .and_return stub(statuses: [build(:status)])
    subject.search
  end

  describe "geo" do
    let(:geo_options) { { radius: radius, geocode: geocode, latitude: latitude, longitude: longitude } }
    let(:radius) { "5" }
    let(:geocode) { "1" }
    let(:latitude) { "44.954763799999995" }
    let(:longitude) { "-93.27987139999999" }
    let(:passed_geo_param) { { geocode: "#{latitude},#{longitude},#{radius}mi" } }
    describe "all params given" do
      it "calls with geo options" do
        Twitter
        .should_receive(:search)
        .once
        .with(query, passed_geo_param)
        .and_return stub(statuses: [build(:status)])
        subject.search
      end
    end

    describe "params given but geocode falsey" do
      let(:geocode) { "" }
      it "calls with geo options" do
        Twitter
        .should_receive(:search)
        .once
        .with(query, {})
        .and_return stub(statuses: [build(:status)])
        subject.search
      end
    end

    describe "left out radius" do
      let(:radius) { "" }
      let(:passed_geo_param) { { geocode: "#{latitude},#{longitude},10mi" } }
      it "calls with geo options" do
        Twitter
        .should_receive(:search)
        .once
        .with(query, passed_geo_param)
        .and_return stub(statuses: [build(:status)])
        subject.search
      end
    end

    describe "left out latitude" do
      let(:latitude) { "" }
      it "calls with geo options" do
        Twitter
        .should_receive(:search)
        .once
        .with(query, {})
        .and_return stub(statuses: [build(:status)])
        subject.search
      end
    end

    describe "left out longitude" do
      let(:longitude) { "" }
      it "calls with geo options" do
        Twitter
        .should_receive(:search)
        .once
        .with(query, {})
        .and_return stub(statuses: [build(:status)])
        subject.search
      end
    end
  end
end
