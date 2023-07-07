require "rails_helper"

RSpec.describe MovieService do
  before(:each) do
    @service = MovieService.new
  end

  describe "class methods" do
    describe "#top_rated" do
      it "lists the top rated movies", :vcr do
        data = @service.top_rated

        expect(data).to be_a(Hash)
        expect(data[:results]).to be_an(Array)
        expect(data[:results].count).to eq(20)

        movie_data = data[:results].first

        expect(movie_data).to have_key :title
        expect(movie_data[:title]).to be_a(String)

        expect(movie_data).to have_key :vote_average
        expect(movie_data[:vote_average]).to be_a(Float || Integer)
      end
    end

    describe "#search_movies"
  end
end