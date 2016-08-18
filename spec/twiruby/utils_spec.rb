require "spec_helper"

describe Hash do
  let(:hash) { { "aaa" => "bbb", "ccc" => { "ddd" => "eee" } } }
  let(:symbolize_hash) { { :aaa => "bbb", :ccc => { "ddd" => "eee" } } }
  let(:deep_symbolize_hash) { { :aaa => "bbb", :ccc => { :ddd => "eee" } } }

  it "should return a symbolized hash" do
    result = hash.symbolize_keys
    expect(result).to be_a Hash
    expect(result).to eq symbolize_hash
  end

  it "should return a deep symbolized hash" do
    result = hash.deep_symbolize_keys
    expect(result).to be_a Hash
    expect(result).to eq deep_symbolize_hash
  end
end
