require 'spec_helper'
describe StatusDecorator do
  let(:status) { build :status }
  subject { described_class.new status }

  its(:to_s) { should == "<a href=\"https://twitter.com/jphenow\">@jphenow</a>: let's do this <a href=\"https://twitter.com/pbyrne\">@pbyrne</a>, <a href=\"https://twitter.com/#winning\">#winning</a> <a href=\"http://t.co/abc\">http://google.co..</a>" }

  its(:screen_name_link) { should == "<a href=\"https://twitter.com/jphenow\">@jphenow</a>" }
  its(:built_text) { should == "let's do this <a href=\"https://twitter.com/pbyrne\">@pbyrne</a>, <a href=\"https://twitter.com/#winning\">#winning</a> <a href=\"http://t.co/abc\">http://google.co..</a>" }
end
