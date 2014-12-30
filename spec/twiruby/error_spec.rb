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
    context "case /hash/error" do
      before do
        stub_get("/").to_return(:status => 401, :headers => { "content-type" => "application/xml" }, :body =><<EOS
<?xml version="1.0" encoding="UTF-8"?>
<hash>
  <error>Test error</error>
</hash>
EOS
        )
      end

      subject { TwiRuby::Error.parse_message(TwiRuby::Request.new(instance).get("/")) }

      it { is_expected.to eq "Test error" }
    end

    context "case /errors/error" do
      before do
        stub_get("/").to_return(:status => 401, :headers => { "content-type" => "application/xml" }, :body =><<EOS
<?xml version="1.0" encoding="UTF-8"?>
<errors>
  <error code="1">Test error</error>
</errors>
EOS
        )
      end

      subject { TwiRuby::Error.parse_message(TwiRuby::Request.new(instance).get("/")) }

      it { is_expected.to eq "Test error" }
    end
  end
end
