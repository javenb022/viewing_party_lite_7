require "rails_helper"

RSpec.describe "/users/:id/movies/:id/viewing_party/new", type: :feature do
  before(:each) do
    @user1 = create(:user)
    @user2 = create(:user)
    @user3 = create(:user)

    @movie = MovieFacade.new(155)
  end

  describe "When I visit the new viewing party page", :vcr do
    it "I see the name of the movie title and movie duration" do
      visit "/login"
      fill_in "Email", with: @user1.email
      fill_in "Password", with: @user1.password
      click_button "Log In"

      visit new_user_movie_viewing_party_path(@user1, 155)
      expect(page).to have_content("Create a Viewing Party for #{@movie.movie_title}")
      expect(page).to have_content("Duration of Party")
    end
  end

  describe "I see a form to create a new Viewing Party", :vcr do
    it "When a user fills out all fields in the form and clicks submit a new viewing party is created" do
      visit "/login"
      fill_in "Email", with: @user1.email
      fill_in "Password", with: @user1.password
      click_button "Log In"
      
      visit new_user_movie_viewing_party_path(@user1, 155)

      fill_in :duration, with: 300
      fill_in :date, with: "2023/07/8"
      fill_in :start_time, with: Time.now

      check @user2.name.to_s

      click_button "Create Party!"
      expect(current_path).to eq(user_path(@user1))
    end
  end

  describe "If a user does not fill out the entire form", :vcr do
    it "The user does not fill out the date an error message displays" do
      visit "/login"
      fill_in "Email", with: @user1.email
      fill_in "Password", with: @user1.password
      click_button "Log In"

      visit new_user_movie_viewing_party_path(@user1, 155)

      check @user2.name.to_s

      click_button "Create Party!"

      expect(current_path).to eq(new_user_movie_viewing_party_path(@user1, 155))
      expect(page).to have_content("All fields need to be filled out before creating a viewing party!")
    end

    it "The user does not fill out the time an error message displays" do
      visit "/login"
      fill_in "Email", with: @user1.email
      fill_in "Password", with: @user1.password
      click_button "Log In"
      
      visit new_user_movie_viewing_party_path(@user1, 155)

      fill_in :duration, with: 250
      fill_in :date, with: "2023/07/8"

      check @user2.name.to_s

      click_button "Create Party!"

      expect(current_path).to eq(new_user_movie_viewing_party_path(@user1, 155))
      expect(page).to have_content("All fields need to be filled out before creating a viewing party!")
    end
  end
end
