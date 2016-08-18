require "spec_helper"

describe TwiRuby::REST::Request do
  let(:instance) { TwiRuby::REST::Request.new(consumer_key: "CK", consumer_secret: "CS", oauth_token: "AT", oauth_token_secret: "ATS") }
  let(:json) { %({"aaa":"bbb","ccc":{"ddd":"eee"}}) }
  let(:parsed_json) { { :aaa => "bbb", :ccc => { :ddd => "eee" } } }

  describe "#new" do
    subject { instance }

    it "should return a TwiRuby::REST::Request" do
      is_expected.to be_a TwiRuby::REST::Request
    end
  end

  describe "#request" do
    before do
      stub_get("/1.1/help/tos.json").to_return(:status => 200, :body => json)
    end

    it "return a parsed json" do
      result = instance.request(Net::HTTP::Get.new("/1.1/help/tos.json"))
      expect(result).to be_a Hash
      expect(result).to eq parsed_json
    end
  end
end
