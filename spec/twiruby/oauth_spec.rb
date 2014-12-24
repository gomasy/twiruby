require "spec_helper"

describe TwiRuby::OAuth do
  let(:instance) { TwiRuby::OAuth.new(consumer_key: "CK", consumer_secret: "CS", access_token: "AT", access_token_secret: "ATS") }

  describe "#get_request_token" do
    it "raise TwiRuby::Error::Unauthorized" do
      expect do
        instance.get_request_token
      end.to raise_error TwiRuby::Error::Unauthorized
    end
  end

  describe "#get_access_token" do
    it "raise TwiRuby::Error::Unauthorized" do
      expect do
        instance.get_access_token({"oauth_token" => "token", "oauth_token_secret" => "secret"})
      end.to raise_error TwiRuby::Error::Unauthorized
    end
  end
end
