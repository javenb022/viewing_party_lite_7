require "rails_helper"

RSpec.describe "Creates a new User" do
  describe "visit /register" do
    it "has a form to register a new user" do
      visit "/register"

      expect(page).to have_field("Name")
      expect(page).to have_field("Email")
      expect(page).to have_field("Password")
      expect(page).to have_button("Register User")
    end

    it "can register a new user" do
      visit "/register"

      fill_in "Name", with: "Javen"
      fill_in "Email", with: "javenb@gmail.com"
      fill_in "Password", with: "password1"
      fill_in "Password confirmation", with: "password1"
      click_button "Register User"

      expect(current_path).to eq("/users/#{User.all.last.id}")
    end

    it "gives an error if all fields aren't filled out" do
      visit "/register"

      # fill_in "Name", with: "Javen"
      fill_in "Email", with: "javenb22@gmail.com"
      fill_in "Password", with: "password1"
      fill_in "Password confirmation", with: "password1"
      click_button "Register User"

      expect(current_path).to eq("/register")
      expect(page).to have_content("Invalid input")
    end

    it "gives an error if all fields aren't filled out" do
      visit "/register"

      fill_in "Name", with: "Javen"
      # fill_in "Email", with: "javenb22@gmail.com"
      fill_in "Password", with: "password1"
      fill_in "Password confirmation", with: "password1"
      click_button "Register User"

      expect(current_path).to eq("/register")
      expect(page).to have_content("Invalid input")
    end

    it "gives an error if email is not unique" do
      @user_1 = User.create!(name: "Cody", email: "javenb22@gmail.com", password: "password1")
      visit "/register"

      fill_in "Name", with: "Javen"
      fill_in "Email", with: "javenb22@gmail.com"
      fill_in "Password", with: "password1"
      fill_in "Password confirmation", with: "password1"
      click_button "Register User"

      expect(current_path).to eq("/register")
      expect(page).to have_content("Invalid input")
    end

    it "gives an error if all fields aren't filled out" do
      visit "/register"

      fill_in "Name", with: "Javen"
      fill_in "Email", with: "javenb@gmail.com"
      # fill_in "Password", with: "password1"
      fill_in "Password confirmation", with: "password1"
      click_button "Register User"

      expect(current_path).to eq("/register")
      expect(page).to have_content("Invalid input")
    end

    it "gives an error if all fields aren't filled out" do
      visit "/register"

      fill_in "Name", with: "Javen"
      fill_in "Email", with: "javenb@gmail.com"
      fill_in "Password", with: "password1"
      # fill_in "Password confirmation", with: "password1"
      click_button "Register User"

      expect(current_path).to eq("/register")
      expect(page).to have_content("Invalid input")
    end

    it "gives an error if passwords do not match" do
      visit "/register"

      fill_in "Name", with: "Javen"
      fill_in "Email", with: "javenb22@gmail.com"
      fill_in "Password", with: "password1"
      fill_in "Password confirmation", with: "password"
      click_button "Register User"

      expect(current_path).to eq("/register")
      expect(page).to have_content("Invalid input")
    end
  end
end
