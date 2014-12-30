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
        stub_get("/").to_return(:status => 401, :headers => { "content-type" => "application/xml" }, :body =><<EOS
<?xml version="1.0" encoding="UTF-8"?>
<hash>
  <error>Test error</error>
</hash>
EOS
        )
      end

      it "should raise TwiRuby::Error::Unauthorized" do
        expect do
          TwiRuby::Error.parse_message(TwiRuby::Request.new(instance).get("/"))
        end.to raise_error TwiRuby::Error::Unauthorized, "Test error"
      end
    end

    context "case of xml" do
      before do
        stub_get("/").to_return(:status => 401, :headers => { "content-type" => "application/xml" }, :body =><<EOS
<?xml version="1.0" encoding="UTF-8"?>
<errors>
  <error code="1">Test error</error>
</errors>
EOS
        )
      end

      it "should raise TwiRuby::Error::Unauthorized" do
        expect do
          TwiRuby::Error.parse_message(TwiRuby::Request.new(instance).get("/"))
        end.to raise_error TwiRuby::Error::Unauthorized, "Test error"
      end
    end

    context "case of html(?)" do
      before do
        stub_get("/").to_return(:status => 401, :headers => { "content-type" => "text/html" }, :body => "Test error")
      end

      it "should raise TwiRuby::Error::Unauthorized" do
        expect do
          TwiRuby::Error.parse_message(TwiRuby::Request.new(instance).get("/"))
        end.to raise_error TwiRuby::Error::Unauthorized, "Test error"
      end
    end
  end
end
