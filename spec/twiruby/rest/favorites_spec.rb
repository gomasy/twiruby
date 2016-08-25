require "spec_helper"

describe TwiRuby::REST::Favorites do
  let(:instance) { TwiRuby::REST::Client.new(consumer_key: "CK", consumer_secret: "CS", oauth_token: "AT", oauth_token_secret: "ATS") }

  describe "#favorites_list" do
    before do
      stub_get("/1.1/favorites/list.json").to_return(:status => 200, :body => fixtures("statuses.json"))
    end

    it "return an array of favorited statuses" do
      statuses = instance.favorites_list
      expect(statuses).to be_a Array
      expect(statuses[0]).to be_a Hash
      expect(statuses[0][:id]).to eq 350499641130889218
      expect(statuses[1][:id]).to eq 275824752692707328
    end
  end

  describe "#favorites_destroy" do
    before do
      stub_post("/1.1/favorites/destroy.json").to_return(:status => 200, :headers => { "content-type" => "application/json;charset=utf-8" }, :body => fixtures("status.json"))
    end

    it "return a favorited status" do
      status = instance.favorites_destroy(20303971)
      expect(status).to be_a Hash
      expect(status[:id]).to eq 20303971
    end
  end

  describe "#favorites_create" do
    before do
      stub_post("/1.1/favorites/create.json").to_return(:status => 200, :headers => { "content-type" => "application/json;charset=utf-8" }, :body => fixtures("status.json"))
    end

    it "return a favorited status" do
      status = instance.favorites_create(20303971)
      expect(status).to be_a Hash
      expect(status[:id]).to eq 20303971
    end
  end
end
