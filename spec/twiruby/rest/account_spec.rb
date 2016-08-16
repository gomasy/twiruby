require "spec_helper"

describe TwiRuby::REST::Account do
  let(:instance) { TwiRuby::REST::Client.new(consumer_key: "CK", consumer_secret: "CS", oauth_token: "AT", oauth_token_secret: "ATS") }

  describe "#settings" do
    before do
      stub_get("/1.1/account/settings.json").to_return(:status => 200, :body => fixtures("account.json"))
    end

    it "return an account" do
      account = instance.settings
      expect(account).to be_a Hash
      expect(account[:screen_name]).to eq "theSeanCook"
    end
  end

  describe "#update_settings" do
    before do
      stub_post("/1.1/account/settings.json?screen_name=theSeanCook").to_return(:status => 200, :headers => { "content-type" => "application/json;utf-8" }, :body => fixtures("account.json"))
    end

    it "return an account" do
      account = instance.update_settings(:screen_name => "theSeanCook")
      expect(account).to be_a Hash
      expect(account[:screen_name]).to eq "theSeanCook"
    end
  end

  describe "#verify_credentials" do
    before do
      stub_get("/1.1/account/verify_credentials.json").to_return(:status => 200, :body => fixtures("profile.json"))
    end

    it "return an authenticated user" do
      user = instance.verify_credentials
      expect(user).to be_a Hash
      expect(user[:screen_name]).to eq "theSeanCook"
    end
  end

  describe "#update_profile" do
    before do
      stub_post("/1.1/account/update_profile.json?screen_name=theSeanCook").to_return(:status => 200, :headers => { "content-type" => "application/json;utf-8" }, :body => fixtures("profile.json"))
    end

    it "return an authenticated user" do
      user = instance.update_profile(:screen_name => "theSeanCook")
      expect(user).to be_a Hash
      expect(user[:screen_name]).to eq "theSeanCook"
    end
  end
end
