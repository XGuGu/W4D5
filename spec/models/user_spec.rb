require 'rails_helper'

RSpec.describe User, type: :model do
  it {should validate_presence_of(:username)}
  it {should validate_presence_of(:password_digest)}
  it {should validate_presence_of(:session_token)}
  it {should validate_length_of(:password).is_at_least(6)}

  describe "uniqueness" do

    before :each do
      create(:user)
    end

    it {should validate_uniqueness_of(:username)}
    it {should validate_uniqueness_of(:session_token)}
  end

  describe "is_password?" do

    let!(:user) {create(:user)}

    context "with a valid password" do
      it "should return true" do
        expect(user.is_password?('pokemon')).to be(true)
      end
    end

    context "with a invalid password" do
      it "should return false" do
        expect(user.is_password?('starwars')).to be(false)
      end
    end
  end

  describe ".find_by_credentials" do
    let(:user) {build(:user)}
    before { user.save! }

    it "returns user given good credentials" do
      # debugger
      expect(User.find_by_credentials(User.last.username, "pokemon")).to eq(user)
    end

    it "returns nil given bad credentials" do
      expect(User.find_by_credentials(User.last.username, "starwars")).to eq(nil)
    end
  end

  describe "#reset_session_token" do
    let(:user) {build(:user)}

    it "sets a new session token on the user" do
      user.valid?
      old_session_token = user.session_token
      user.reset_session_token
      expect(user.session_token).to_not eq(old_session_token)
    end

    it "returns the new session token" do
      expect(user.reset_session_token).to eq(user.session_token)
    end
  end

end
