require "spec_helper"

describe TwiRuby::Error do
  describe ".raise" do
    subject { TwiRuby::Error.raise("304") }

    it "should return a TwiRuby::Error::NotModified" do
      is_expected.to be TwiRuby::Error::NotModified
    end
  end
end
