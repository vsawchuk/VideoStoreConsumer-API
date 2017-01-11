require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  let (:movie_data) {
    {
      "title": "Hidden Figures",
      "overview": "Some text",
      "release_date": "1960-06-16",
      "inventory": 8
    }
  }

  before do
    @movie = Movie.new(movie_data)
  end

  describe "Constructor" do
    it "Can be created" do
      Movie.create!(movie_data)
    end

    it "Has rentals" do
      @movie.must_respond_to :rentals
    end

    it "Has customers" do
      @movie.must_respond_to :customers
    end
  end
end
