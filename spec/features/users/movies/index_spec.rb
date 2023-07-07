require "rails_helper"

describe "User Movies Index Page" do
  before :each do
    @user_1 = User.create!(name: "Simon", email: "simon@gmail.com")

    visit "/users/#{@user_1.id}/movies"
  end

  it "should display movie details" do
    expect(page).to have_button("Return to Discover Page")
    # title (As a link to the movie details page)
    # Vote Average of the movie
    # max 20 results 
  end
end