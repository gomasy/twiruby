require "spec_helper"

describe TwiRuby::Error do
  TwiRuby::Error::ERRORS.each do |code, type|
    describe "should return #{type}" do
      subject { TwiRuby::Error.type(code) }
      it { is_expected.to be type }
    end
  end

  describe ".parse_message" do
    # TODO
  end

  describe ".parse_xml_message" do
    # TODO
  end

  describe ".parse_json_message" do
    # TODO
  end
end
