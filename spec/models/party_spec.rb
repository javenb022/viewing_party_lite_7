require "rails_helper"

RSpec.describe Party do
  before(:each) do
    @user1 = User.create!(name: "Cody", email: "code@gmail.com", password: "password1")
    @user2 = User.create!(name: "Javen", email: "javenb022@gmail.com", password: "password1")

    @party1 = Party.create!(movie_id: 1, duration: 120, date: "2021-07-06", start_time: "2021-07-06 12:00:00")
    @party2 = Party.create!(movie_id: 2, duration: 120, date: "2021-07-06", start_time: "2021-07-06 12:00:00")
    @party3 = Party.create!(movie_id: 3, duration: 120, date: "2021-07-06", start_time: "2021-07-06 12:00:00")

    @user_party1 = UserParty.create!(user_id: @user1.id, party_id: @party1.id, is_host: true)
    @user_party2 = UserParty.create!(user_id: @user1.id, party_id: @party2.id, is_host: false)
    @user_party3 = UserParty.create!(user_id: @user2.id, party_id: @party1.id, is_host: false)
    @user_party4 = UserParty.create!(user_id: @user2.id, party_id: @party2.id, is_host: true)
    @user_party5 = UserParty.create!(user_id: @user1.id, party_id: @party3.id, is_host: false)
  end

  describe "relationships" do
    it { should have_many :user_parties }
    it { should have_many(:users).through(:user_parties) }
  end

  describe "instance methods" do
    describe "#host_name" do
      it "returns the name of the host of the party" do
        expect(@party1.host_name).to eq(@user1.name)
      end
    end

    describe "#invited_users" do
      it "returns all users invited to the party" do
        expect(@party1.invited_users).to eq([@user2])
      end
    end
  end
end
  