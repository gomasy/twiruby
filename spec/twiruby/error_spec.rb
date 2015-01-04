require "spec_helper"

describe TwiRuby::Error do
  let(:instance) { TwiRuby::OAuth.new }

  describe ".type" do
    TwiRuby::Error::ERRORS.each do |code, type|
      describe "should return #{type}" do
        subject { TwiRuby::Error.type(code) }
        it { is_expected.to be type }
      end
    end
  end

  describe ".parse_message" do
    context "case of xml" do
      before do
        stub_get("/").to_return(:status => 401, :headers => { "content-type" => "application/xml" }, :body => fixtures("error1.xml"))
      end

      it "should raise TwiRuby::Error::Unauthorized" do
        expect do
          TwiRuby::Error.parse_message(TwiRuby::REST::Request.new(instance.tokens).get("/"))
        end.to raise_error TwiRuby::Error::Unauthorized, "Test error"
      end
    end

    context "case of xml" do
      before do
        stub_get("/").to_return(:status => 401, :headers => { "content-type" => "application/xml" }, :body => fixtures("error2.xml"))
      end

      it "should raise TwiRuby::Error::Unauthorized" do
        expect do
          TwiRuby::Error.parse_message(TwiRuby::REST::Request.new(instance.tokens).get("/"))
        end.to raise_error TwiRuby::Error::Unauthorized, "Test error"
      end
    end

    context "case of html(?)" do
      before do
        stub_get("/").to_return(:status => 401, :headers => { "content-type" => "text/html" }, :body => "Test error")
      end

      it "should raise TwiRuby::Error::Unauthorized" do
        expect do
          TwiRuby::Error.parse_message(TwiRuby::REST::Request.new(instance.tokens).get("/"))
        end.to raise_error TwiRuby::Error::Unauthorized, "Test error"
      end
    end
  end
end
