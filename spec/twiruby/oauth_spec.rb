require "spec_helper"

describe TwiRuby::OAuth do
  let(:instance) { TwiRuby::OAuth.new(consumer_key: "CK", consumer_secret: "CS") }
  let(:body) { "oauth_token=AT&oauth_token_secret=ATS" }

  describe "#new" do
    subject { instance }

    it "should return a TwiRuby::OAuth" do
      is_expected.to be_a TwiRuby::OAuth
    end
  end

  describe "#get_request_token" do
    before do
      stub_post("/oauth/request_token").to_return(:status => 200, :body => body)
    end

    it "return false if consumer tokens are not present" do
      client = TwiRuby::OAuth.new(consumer_key: "CK")
      expect(client.consumer_token?).to be false
    end

    it "return true if consumer tokens are present" do
      client = TwiRuby::OAuth.new(consumer_key: "CK", consumer_secret: "CS")
      expect(client.consumer_token?).to be true
    end

    it "should return request token" do
      token = instance.get_request_token
      expect(token[:oauth_token]).to eq "AT"
      expect(token[:oauth_token_secret]).to eq "ATS"
      expect(token[:authorize_url]).to eq %(#{TwiRuby::REST::BASE_URL}/oauth/authorize?#{body})
    end
  end

  describe "#get_access_token" do
    before do
      stub_post("/oauth/access_token").to_return(:status => 200, :body => body)
    end

    it "return false if oauth tokens are not present" do
      client = TwiRuby::OAuth.new(access_token: "AT")
      expect(client.oauth_token?).to be false
    end

    it "return true if oauth tokens are present" do
      client = TwiRuby::OAuth.new(access_token: "AT", access_token_secret: "ATS")
      expect(client.oauth_token?).to be true
    end

    it "should return access tokens" do
      token = instance.get_access_token("oauth_token" => "AT", "oauth_token_secret" => "ATS")
      expect(token[:oauth_token]).to eq "AT"
      expect(token[:oauth_token_secret]).to eq "ATS"
    end
  end
end
