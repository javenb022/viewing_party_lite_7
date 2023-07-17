require "rails_helper"
  
RSpec.describe User do
  before :each do
    @user1 = User.create!(name: "Cody", email: "code@gmail.com")
    @user2 = User.create!(name: "Javen", email: "javenb022@gmail.com")

    @party1 = Party.create!(movie_id: 1, duration: 120, date: "2021-07-06", start_time: "2021-07-06 12:00:00")
    @party2 = Party.create!(movie_id: 2, duration: 120, date: "2021-07-06", start_time: "2021-07-06 12:00:00")
    @party3 = Party.create!(movie_id: 3, duration: 120, date: "2021-07-06", start_time: "2021-07-06 12:00:00")

    @user_party1 = UserParty.create!(user_id: @user1.id, party_id: @party1.id, is_host: true)
    @user_party2 = UserParty.create!(user_id: @user1.id, party_id: @party2.id, is_host: nil)
    @user_party3 = UserParty.create!(user_id: @user2.id, party_id: @party1.id, is_host: nil)
    @user_party4 = UserParty.create!(user_id: @user2.id, party_id: @party2.id, is_host: true)
    @user_party5 = UserParty.create!(user_id: @user1.id, party_id: @party3.id, is_host: nil)
  end

  describe "relationships" do
    it { should have_many :user_parties }
    it { should have_many(:parties).through(:user_parties) }
  end

  describe "instance methods" do
    describe "#invited_parties" do
      it "returns all parties a user is invited to" do
        expect(@user1.invited_parties).to eq([@party2, @party3])
      end
    end
    describe "#hosting_parties" do
      it "returns all parties a user is hosting" do
        expect(@user1.hosted_parties).to eq([@party1])
      end
    end
  end

  describe "class methods" do
    describe ".other_users" do
      it "returns all users except the user with the given id" do
        expect(User.other_users(@user1.id)).to be_a ActiveRecord::Relation
        expect(User.other_users(@user1.id).first).to be_a User
      end
    end
  end
end
