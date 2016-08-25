require "spec_helper"

describe TwiRuby::REST::Users do
  let(:instance) { TwiRuby::REST::Client.new(consumer_key: "CK", consumer_secret: "CS", oauth_token: "AT", oauth_token_secret: "ATS") }

  describe "#users_lookup" do
    before do
      stub_get("/1.1/users/lookup.json?screen_name=twitter,null").to_return(:status => 200, :body => fixtures("users.json"))
    end

    it "should returns users" do
      users = instance.users_lookup(:screen_name => "twitter,null")
      expect(users).to be_a Array
      expect(users[0]).to be_a Hash
      expect(users[0][:screen_name]).to eq "twitter"
      expect(users[1][:screen_name]).to eq "null"
    end
  end

  describe "#users_show" do
    before do
      stub_get("/1.1/users/show.json?screen_name=null").to_return(:status => 200, :body => fixtures("user.json"))
    end

    it "should return a user" do
      user = instance.users_show(:screen_name => "null")
      expect(user).to be_a Hash
      expect(user[:screen_name]).to eq "null"
    end
  end

  describe "#search" do
    before do
      stub_get("/1.1/users/search.json?q=null").to_return(:status => 200, :body => fixtures("search.json"))
    end

    it "should returns users" do
      users = instance.search("null")
      expect(users).to be_a Array
      expect(users[0]).to be_a Hash
      expect(users[0][:screen_name]).to eq "null"
    end
  end

  describe "#profile_banner" do
    before do
      stub_get("/1.1/users/profile_banner.json?screen_name=twitter").to_return(:status => 200, :body => fixtures("profile_banner.json"))
    end

    it "should returns profile banner urls" do
      urls = instance.profile_banner(:screen_name => "twitter")
      expect(urls).to be_a Hash
      expect(urls[:sizes][:web][:url]).to eq "https://pbs.twimg.com/profile_banners/783214/1470727429/web"
    end
  end

  describe "#suggestions" do
    before do
      stub_get("/1.1/users/suggestions.json").to_return(:status => 200, :body => fixtures("suggestions.json"))
    end

    it "should returns suggestions" do
      suggestions = instance.suggestions
      expect(suggestions).to be_a Array
      expect(suggestions[0]).to be_a Hash
      expect(suggestions[0][:slug]).to eq "twitter"
    end
  end

  describe "#suggestions_slug" do
    before do
      stub_get("/1.1/users/suggestions/twitter.json").to_return(:status => 200, :body => fixtures("suggestions_slug.json"))
    end

    it "should returns slugs" do
      slugs = instance.suggestions_slug("twitter")
      expect(slugs).to be_a Hash
      expect(slugs[:users]).to be_a Array
      expect(slugs[:users][0][:screen_name]).to eq "TwitterJP"
    end
  end

  describe "#suggestions_slug_members" do
    before do
      stub_get("/1.1/users/suggestions/twitter/members.json").to_return(:status => 200, :body => fixtures("suggestions_slug_members.json"))
    end

    it "should returns slug members" do
      members = instance.suggestions_slug_members("twitter")
      expect(members).to be_a Array
      expect(members[0]).to be_a Hash
      expect(members[0][:screen_name]).to eq "TwitterJP"
    end
  end

  describe "#report_spam" do
    before do
      stub_post("/1.1/users/report_spam.json").to_return(:status => 200, :headers => { "content-type" => "application/json;charset=utf-8" }, :body => fixtures("user.json"))
    end

    it "should return a user" do
      user = instance.report_spam(:screen_name => "null")
      expect(user).to be_a Hash
      expect(user[:screen_name]).to eq "null"
    end
  end
end
