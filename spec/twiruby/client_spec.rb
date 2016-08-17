require "spec_helper"

describe TwiRuby::Client do
  let(:instance) { TwiRuby::Client.new(consumer_key: "CK", consumer_secret: "CS", oauth_token: "AT", oauth_token_secret: "ATS") }
  let(:instance_invalid) { TwiRuby::Client.new(consumer_key: "CK", oauth_token: "AT") }

  describe "#new" do
    subject { instance }

    it "should return a TwiRuby::Client" do
      is_expected.to be_a TwiRuby::Client
    end
  end

  describe "#tokens" do
    it "should return tokens" do
      tokens = instance.tokens
      expect(tokens[:consumer_key]).to eq "CK"
      expect(tokens[:consumer_secret]).to eq "CS"
      expect(tokens[:oauth_token]).to eq "AT"
      expect(tokens[:oauth_token_secret]).to eq "ATS"
    end
  end

  describe "#consumer_token?" do
    it "should return true" do
      expect(instance.consumer_token?).to be true
    end

    it "should return false" do
      expect(instance_invalid.consumer_token?).to be false
    end
  end

  describe "#oauth_token?" do
    it "should return true" do
      expect(instance.oauth_token?).to be true
    end

    it "should return false" do
      expect(instance_invalid.oauth_token?).to be false
    end
  end
end
