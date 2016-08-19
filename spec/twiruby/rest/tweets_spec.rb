require "spec_helper"
require "uri"

describe TwiRuby::REST::Tweets do
  let(:instance) { TwiRuby::REST::Client.new(consumer_key: "CK", consumer_secret: "CS", access_token: "AT", access_token_secret: "ATS") }

  describe "#status_destroy" do
    before do
      stub_post("/1.1/statuses/destroy/20303971.json").to_return(:status => 200, :headers => { "content-type" => "application/json;utf-8" }, :body => fixtures("status.json"))
    end

    it "return a destroyed status" do
      status = instance.status_destroy(20303971)
      expect(status).to be_a Hash
      expect(status[:text]).to eq "nullin it up"
    end
  end

  describe "#status_lookup" do
    before do
      @id = [20303971,20304451,275824752692707328,350499641130889218]
      stub_get("/1.1/statuses/lookup.json?id=#{@id.join(",")}").to_return(:status => 200, :headers => { "content-type" => "application/json;utf-8" }, :body => fixtures("statuses.json"))
    end

    it "returns an array of statuses" do
      statuses = instance.status_lookup(@id)
      expect(statuses).to be_a Array
      expect(statuses.last[:text]).to eq "nullin it up"
    end
  end

  describe "#oembed" do
    context "with a id" do
      before do
        stub_get("/1.1/statuses/oembed.json?id=20303971").to_return(:status => 200, :headers => { "content-type" => "application/json;utf-8" }, :body => fixtures("oembed.json"))
      end

      it "return a status" do
        status = instance.oembed(:id => 20303971)
        expect(status).to be_a Hash
        expect(status[:author_name]).to eq "not quite nothing"
      end
    end

    context "with a url" do
      before do
        stub_get("/1.1/statuses/oembed.json?url=https://twitter.com/null/status/20303971").to_return(:status => 200, :headers => { "content-type" => "application/json;utf-8" }, :body => fixtures("oembed.json"))
      end

      it "return a status" do
        status = instance.oembed(:url => URI.parse("https://twitter.com/null/status/20303971"))
        expect(status).to be_a Hash
        expect(status[:author_name]).to eq "not quite nothing"
      end
    end
  end

  describe "#retweet" do
    before do
      stub_post("/1.1/statuses/retweet/20303971.json").to_return(:status => 200, :headers => { "content-type" => "application/json;utf-8" }, :body => fixtures("retweet.json"))
    end

    it "return a retweeted status" do
      status = instance.retweet(20303971)
      expect(status).to be_a Hash
      expect(status[:retweeted_status][:text]).to eq "nullin it up"
    end
  end

  describe "#unretweet" do
    before do
      stub_post("/1.1/statuses/unretweet/551893403395313664.json").to_return(:status => 200, :headers => { "content-type" => "application/json;utf-8" }, :body => fixtures("status.json"))
    end

    it "return an original status" do
      status = instance.unretweet(551893403395313664)
      expect(status).to be_a Hash
      expect(status[:id]).to eq 20303971
    end
  end

  describe "#retweets" do
    before do
      stub_get("/1.1/statuses/retweets/20303971.json").to_return(:status => 200, :headers => { "content-type" => "application/json;utf-8" }, :body => fixtures("retweets.json"))
    end

    it "returns an array of retweeted statuses" do
      statuses = instance.retweets(20303971)
      expect(statuses).to be_a Array
      expect(statuses.first[:retweeted_status][:text]).to eq "nullin it up"
    end
  end

  describe "#retweeters" do
    before do
      stub_get("/1.1/statuses/retweeters/ids.json?id=20303971").to_return(:status => 200, :headers => { "content-type" => "application/json;utf-8" }, :body => fixtures("retweeters.json"))
    end

    it "returns an array of ids" do
      ids = instance.retweeters(20303971)
      expect(ids).to be_a Hash
      expect(ids[:ids]).to be_a Array
      expect(ids[:ids].first).to eq 155148649
    end
  end

  describe "#status_show" do
    before do
      stub_get("/1.1/statuses/show/20303971.json").to_return(:status => 200, :headers => { "content-type" => "application/json;utf-8" }, :body => fixtures("status.json"))
    end

    it "return a status" do
      status = instance.status_show(20303971)
      expect(status).to be_a Hash
      expect(status[:text]).to eq "nullin it up"
    end
  end

  describe "#update" do
    before do
      stub_post("/1.1/statuses/update.json").to_return(:status => 200, :headers => { "content-type" => "application/json;utf-8" }, :body => fixtures("status.json"))
    end

    it "return a status" do
      status = instance.update("nullin it up")
      expect(status).to be_a Hash
      expect(status[:text]).to eq "nullin it up"
    end
  end
end
