require "spec_helper"

describe TwiRuby::OAuth do
  let(:instance) { TwiRuby::OAuth.new(consumer_key: "CK", consumer_secret: "CS") }
  let(:body) { "oauth_token=AT&oauth_token_secret=ATS" }

  describe "#get_request_token" do
    before do
      stub_post("/oauth/request_token").to_return(:status => 200, :body => body)
      @token = instance.get_request_token
    end

    it "return true if consumer tokens are present" do
      expect(instance.has_consumer_token?).to be true
    end

    it "should return request token" do
      expect(@token["oauth_token"]).to eq "AT"
      expect(@token["oauth_token_secret"]).to eq "ATS"
      expect(@token["authorize_url"]).to eq("#{TwiRuby::OAuth::BASE_URL}/oauth/authorize?#{body}")
    end
  end

  describe "#get_access_token" do
    before do
      stub_post("/oauth/access_token").to_return(:status => 200, :body => body)
      @token = instance.get_access_token("oauth_token" => "PS", "oauth_token_secret" => "PSS")
    end

    it "return true if oauth tokens are present" do
      expect(instance.has_oauth_token?).to be true
    end

    it "should return access tokens" do
      expect(@token["oauth_token"]).to eq "AT"
      expect(@token["oauth_token_secret"]).to eq "ATS"
    end
  end

  describe "#get_response" do
    before do
      stub_post("/").to_return(:status => 401, :body => "Test error")
    end

    it "raise TwiRuby::Error::Unauthorized" do
      expect do
        instance.get_response(TwiRuby::Request.new(instance), "/")
      end.to raise_error TwiRuby::Error::Unauthorized
    end
  end
end
