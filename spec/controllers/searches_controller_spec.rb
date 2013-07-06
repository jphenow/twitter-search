require 'spec_helper'
describe SearchesController do
  before do
    SearchEngine.any_instance.stub search: [build(:status)]
  end

  describe "GET show" do
    before do
      get :show
    end

    it "loads show" do
      response.should render_template("show")
    end

    it "is successful" do
      response.should be_success
    end
  end

  describe "POST create" do
    before do
      post :create, "@jphenow"
    end

    its(:results) { should have(1).status_decorators }

    it "loads results" do
      response.should render_template("results")
    end

    it "is successful" do
      response.should be_success
    end
  end
end
