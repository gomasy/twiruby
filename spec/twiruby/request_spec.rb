require "spec_helper"

describe TwiRuby::Request do
  let(:oauth) { TwiRuby::OAuth.new(consumer_key: "CK", consumer_secret: "CS", access_token: "AT", access_token_secret: "ATS") }
  let(:instance) { TwiRuby::Request.new(oauth) }

  describe ".new" do
    subject { instance }

    it "should return a TwiRuby::Request" do
      is_expected.to be_a TwiRuby::Request
    end
  end

  describe "#get" do
    subject { instance.get("/") }

    it "should return 404" do
      is_expected.to be_a Net::HTTPNotFound
    end
  end

  describe "#post" do
    subject { instance.post("/?query=content", "body" => "content") }

    it "should return 404" do
      is_expected.to be_a Net::HTTPNotFound
    end
  end

  describe "#user_agent" do
    subject { instance.user_agent }

    it "should return a String" do
      is_expected.to be_a String
    end

    it "should set user_agent" do
      instance.user_agent = "ua"
      is_expected.to eq "ua"
    end
  end
end
