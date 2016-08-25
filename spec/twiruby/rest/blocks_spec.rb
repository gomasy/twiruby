require "spec_helper"

describe TwiRuby::REST::Blocks do
  let(:instance) { TwiRuby::REST::Client.new(consumer_key: "CK", consumer_secret: "CS", access_token: "AT", access_token_secret: "ATS") }

  describe "#blocks_list" do
    before do
      stub_get("/1.1/blocks/list.json").to_return(:status => 200, :body => fixtures("users_list.json"))
    end

    it "return a blocks list" do
      blocks = instance.blocks_list
      expect(blocks).to be_a Hash
      expect(blocks[:users]).to be_a Array
      expect(blocks[:users].first[:id]).to eq 509466276
    end
  end

  describe "#blocks_ids" do
    before do
      stub_get("/1.1/blocks/ids.json").to_return(:status => 200, :body => fixtures("users_ids.json"))
    end

    it "returns an array of blocked ids" do
      ids = instance.blocks_ids
      expect(ids).to be_a Hash
      expect(ids[:ids]).to be_a Array
      expect(ids[:ids].first).to eq 155148649
    end
  end

  describe "#block" do
    before do
      stub_post("/1.1/blocks/create.json").to_return(:status => 200, :headers => { "content-type" => "application/json;charset=utf-8" }, :body => fixtures("user.json"))
    end

    it "return a blocked user" do
      user = instance.block(:user_id => 3562471)
      expect(user).to be_a Hash
      expect(user[:id]).to eq 3562471
    end
  end

  describe "#unblock" do
    before do
      stub_post("/1.1/blocks/destroy.json").to_return(:status => 200, :headers => { "content-type" => "application/json;charset=utf-8" }, :body => fixtures("user.json"))
    end

    it "return a unblocked user" do
      user = instance.unblock(:user_id => 3562471)
      expect(user).to be_a Hash
      expect(user[:id]).to eq 3562471
    end
  end
end
