require "spec_helper"

describe Hash do
  let(:query) { { "sushi" => "🍣", "unko" => "💩" } }
  let(:hash) { { "aaa" => "bbb", "ccc" => { "ddd" => "eee" } } }
  let(:symbolize_hash) { { :aaa => "bbb", :ccc => { "ddd" => "eee" } } }
  let(:deep_symbolize_hash) { { :aaa => "bbb", :ccc => { :ddd => "eee" } } }

  describe "#to_q" do
    it "should return a query string" do
      result = query.to_q
      expect(result).to be_a String
      expect(result).to eq "sushi=%F0%9F%8D%A3&unko=%F0%9F%92%A9"
    end
  end

  describe "#symbolize_keys" do
    it "should return a symbolized hash" do
      result = hash.symbolize_keys
      expect(result).to be_a Hash
      expect(result).to eq symbolize_hash
    end
  end

  describe "#deep_symbolize_keys" do
    it "should return a deep symbolized hash" do
      result = hash.deep_symbolize_keys
      expect(result).to be_a Hash
      expect(result).to eq deep_symbolize_hash
    end
  end
end
