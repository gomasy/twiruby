require "spec_helper"

describe TwiRuby::OAuth do
  let(:instance) { TwiRuby::OAuth.new }

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

  describe "#has_consumer_token?" do
    subject { instance.has_consumer_token? }

    it "should return false" do
      instance.consumer_key = "CK"

      is_expected.to be false
    end

    it "should return true" do
      instance.consumer_key = "CK"
      instance.consumer_secret = "CS"

      is_expected.to be true
    end
  end

  describe "#has_oauth_token?" do
    subject { instance.has_oauth_token? }

    it "should return false" do
      instance.access_token = "AT"

      is_expected.to be false
    end

    it "should return true" do
      instance.access_token = "AT"
      instance.access_token_secret = "ATS"

      is_expected.to be true
    end
  end
end
