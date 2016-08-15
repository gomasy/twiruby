require "spec_helper"

describe TwiRuby::REST::Account do
  let(:instance) { TwiRuby::REST::Client.new(consumer_key: "CK", consumer_secret: "CS", access_token: "AT", access_token_secret: "ATS") }

  describe "#settings" do
    before do
      stub_post("/1.1/account/settings.json").to_return(:status => 200, :headers => { "content-type" => "application/json;utf-8" }, :body => fixtures("account.json"))
    end

    it "return an account" do
      account = instance.settings("screen_name" => "theSeanCook")
      expect(account).to be_a Hash
      expect(account["screen_name"]).to eq "theSeanCook"
    end
  end
end
