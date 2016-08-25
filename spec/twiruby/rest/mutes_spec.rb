require "spec_helper"

describe TwiRuby::REST::Mutes do
  let(:instance) { TwiRuby::REST::Client.new(consumer_key: "CK", consumer_secret: "CS", oauth_token: "AT", oauth_token_secret: "ATS") }

  describe "#mute" do
    before do
      stub_post("/1.1/mutes/users/create.json").to_return(:status => 200, :headers => { "content-type" => "application/json;charset=utf-8" }, :body => fixtures("user.json"))
    end

    it "return a muted user" do
      user = instance.mute(:user_id => 3562471)
      expect(user).to be_a Hash
      expect(user[:id]).to eq 3562471
    end
  end

  describe "#unmute" do
    before do
      stub_post("/1.1/mutes/users/destroy.json").to_return(:status => 200, :headers => { "content-type" => "application/json;charset=utf-8" }, :body => fixtures("user.json"))
    end

    it "return a muted user" do
      user = instance.unmute(:user_id => 3562471)
      expect(user).to be_a Hash
      expect(user[:id]).to eq 3562471
    end
  end

  describe "#mutes_ids" do
    before do
      stub_get("/1.1/mutes/users/ids.json").to_return(:status => 200, :body => fixtures("users_ids.json"))
    end

    it "return an array of muted users ids" do
      ids = instance.mutes_ids
      expect(ids).to be_a Hash
      expect(ids[:ids]).to be_a Array
      expect(ids[:ids].first).to eq 155148649
    end
  end

  describe "#mutes_list" do
    before do
      stub_get("/1.1/mutes/users/list.json").to_return(:status => 200, :body => fixtures("users_list.json"))
    end

    it "return an array of muted users" do
      list = instance.mutes_list
      expect(list).to be_a Hash
      expect(list[:users]).to be_a Array
      expect(list[:users].first[:id]).to eq 509466276
    end
  end
end
