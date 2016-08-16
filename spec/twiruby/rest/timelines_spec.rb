require "spec_helper"

describe TwiRuby::REST::Timelines do
  let(:instance) { TwiRuby::REST::Client.new(consumer_key: "CK", consumer_secret: "CS", oauth_token: "AT", oauth_token_secret: "ATS") }

  describe "#home_timeline" do
    before do
      stub_get("/1.1/statuses/home_timeline.json").to_return(:status => 200, :body => fixtures("statuses.json"))
    end

    it "returns the most recent tweets" do
      statuses = instance.home_timeline
      expect(statuses).to be_a Array
      expect(statuses.last[:text]).to eq "nullin it up"
    end
  end

  describe "#mentions_timeline" do
    before do
      stub_get("/1.1/statuses/mentions_timeline.json").to_return(:status => 200, :body => fixtures("statuses.json"))
    end

    it "returns the most recent tweets" do
      statuses = instance.mentions_timeline
      expect(statuses).to be_a Array
      expect(statuses.last[:text]).to eq "nullin it up"
    end
  end

  describe "#user_timeline" do
    before do
      stub_get("/1.1/statuses/user_timeline.json?screen_name=null").to_return(:status => 200, :body => fixtures("statuses.json"))
    end

    it "returns the most recent tweets" do
      statuses = instance.user_timeline("screen_name" => "null")
      expect(statuses).to be_a Array
      expect(statuses.last[:text]).to eq "nullin it up"
    end
  end

  describe "#retweets_of_me" do
    before do
      stub_get("/1.1/statuses/retweets_of_me.json").to_return(:status => 200, :body => fixtures("statuses.json"))
    end

    it "returns the most recent tweets" do
      statuses = instance.retweets_of_me
      expect(statuses).to be_a Array
      expect(statuses.last[:text]).to eq "nullin it up"
    end
  end
end
