require "rails_helper"

RSpec.describe "user/movies/index.html" do
  before(:each) do
    @user1 = create(:user)
  end

  describe "When a user visits the discover page", :vcr do
    describe "and search by top rated" do
      it "shows top rated movies" do
        top_movies = MoviesFacade.new.movies

        visit user_discover_path(@user1)
        click_button("Discover Top Rated Movies")

        expect(current_path).to eq(user_movies_path(@user1))

        expect(page).to have_content("Viewing Party")
        expect(page).to have_button("Discover Page")

        top_movies.each do |movie|
          within "#movie_#{movie.id}" do
            expect(page).to have_content(movie.title)
            expect(page).to have_content("Vote Average: #{movie.vote_average}")
          end
        end
      end

      it "has a link to movie show page" do
        top_movies = MoviesFacade.new.movies

        visit user_discover_path(@user1)
        click_button("Discover Top Rated Movies")

        expect(current_path).to eq(user_movies_path(@user1))

        expect(page).to have_content("Viewing Party")
        expect(page).to have_button("Discover Page")

        click_link(top_movies.first.title.to_s)
        expect(current_path).to eq(user_movie_path(@user1, top_movies.first.id))
      end
    end
    describe "and search by title" do
      it "shows movies by title" do
        MoviesFacade.new("The Dark Knight").movies
        visit user_discover_path(@user1)

        fill_in :search_field, with: "The Dark Knight"
        click_button("Search")

        expect(current_path).to eq(user_movies_path(@user1))
      end

      it "has a link to movie show page" do
        MoviesFacade.new("The Dark Knight").movies
        visit user_discover_path(@user1)

        fill_in :search_field, with: "The Dark Knight"
        click_button("Search")

        expect(current_path).to eq(user_movies_path(@user1))

        expect(page).to have_content("Viewing Party")
        expect(page).to have_button("Discover Page")

        click_link("The Dark Knight")
        expect(current_path).to eq("/users/#{@user1.id}/movies/155")
      end
    end

    describe "When a visitor goes to a movie show page" do
      describe "and clicks the button to create a viewing party" do
        it "redirects to the movie show page and displays an error message" do
          top_movies = MoviesFacade.new.movies

          visit user_movie_path(@user1, top_movies.first.id)
          click_button "Create Viewing Party"

          expect(current_path).to eq(user_movie_path(@user1, top_movies.first.id))
          expect(page).to have_content("You must be logged in to do that")
        end
      end
    end
  end
end
