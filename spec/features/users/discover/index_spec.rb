require "rails_helper"

describe "Discover Index Page" do
  before :each do
    @user_1 = User.create!(name: "Simon", email: "simon@gmail.com")

    visit "/users/#{@user_1.id}/discover"
  end

  it "should display ways to discover movies" do
    expect(page).to have_button("Discover Top Rated Movies")
    expect(page).to have_field("Search by Movie Title:")
    expect(page).to have_button("Search")
  end

  it "should take the user to the movies results page from the Discover Top Movies button" do 
    click_button "Discover Top Rated Movies"
    expect(page).to have_current_path("/users/#{@user_1.id}/movies")
  end

  it "should take the user to the movies results page from the Search button" do
    # save_and_open_page
    click_button "Search"
    # expect(page).to have_current_path("/users/#{@user_1.id}/movies")
  end
end