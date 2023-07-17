require "rails_helper"
 
RSpec.describe "/users/:id", type: :feature do
  before(:each) do
    @user1 = create(:user)
    @user2 = create(:user)
    @user3 = create(:user)

    @party1 = create(:party, movie_id: 155)
    @party2 = create(:party, movie_id: 13)

    @user_party1 = UserParty.create!(user: @user1, party: @party2, is_host: nil)
    @user_party2 = UserParty.create!(user: @user3, party: @party1, is_host: nil)
    @user_party3 = UserParty.create!(user: @user2, party: @party1, is_host: nil)
    @user_party4 = UserParty.create!(user: @user1, party: @party1, is_host: true)
    @user_party5 = UserParty.create!(user: @user2, party: @party2, is_host: true)
  end

  describe "When I visit the users dashboard page", :vcr do
    it 'I see <users name> Dashboard" at the top of the page' do
      visit user_path(@user1)

      expect(page).to have_content("#{@user1.name}'s Dashboard")
    end

    it "has a button (Discover Movies)", :vcr do
      visit user_path(@user1)

      expect(page).to have_button("Discover Movies")
    end

    it "has link to movie show page", :vcr do
      visit user_path(@user1)

      expect(page).to have_link("The Dark Knight")

      click_link("The Dark Knight")
      expect(current_path).to eq(user_movie_path(@user1, 155))
    end

    it "has a section that list viewing parties", :vcr do
      MovieFacade.get_movie_title(155)
      forrest_gump = MovieFacade.get_movie_title(13)

      visit user_path(@user1)

      expect(page).to have_content("Parties Hosting")
      expect(page).to have_content("Parties Attending")

      within "#hosting" do
        expect(page).to have_content("The Dark Knight")
        expect(page).to have_css("img")
        expect(page).to have_content("Host: #{@user1.name}")
        within "#invitees" do
          expect(page).to have_content("Invited:")
          expect(page).to have_content(@user2.name)
          expect(page).to have_content(@user3.name)
          expect(page).to_not have_content(@user1.name)
        end
      end

      within "#invited" do
        expect(page).to have_content(forrest_gump)
        expect(page).to have_css("img")
        expect(page).to have_content("Host: #{@user2.name}")
        within "#invitees" do
          expect(page).to have_content("Invited:")
          expect(page).to have_content(@user1.name)
          expect(page).to_not have_content(@user2.name)
        end
      end
    end
  end

  describe 'When I visit the users dashboard page and click "Discover Movies"' do
    it "redirects to a discover page for the specific user", :vcr do
      visit user_path(@user1)
      click_button "Discover Movies"

      expect(current_path).to eq("/users/#{@user1.id}/discover")
      expect(page).to have_content("Discover Movies")
    end
  end
end
