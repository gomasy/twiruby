require "spec_helper"

describe TwiRuby::Streaming::Client do
  let(:instance) { TwiRuby::Streaming::Client.new(consumer_key: "CK", consumer_secret: "CS", oauth_token: "AT", oauth_token_secret: "ATS") }

  describe "#new" do
    subject { instance }

    it "should return a TwiRuby::Streaming::Client" do
      is_expected.to be_a TwiRuby::Streaming::Client
    end
  end
end
