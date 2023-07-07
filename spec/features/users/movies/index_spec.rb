require "rails_helper"

describe "User Movies Index Page" do
  before :each do
    @user_1 = User.create!(name: "Simon", email: "simon@gmail.com")

    visit "/users/#{@user_1.id}/movies"
  end

  it "should display ways to discover movies" do
    expect(page).to have_content("Discover Top Rated Movies")
  end