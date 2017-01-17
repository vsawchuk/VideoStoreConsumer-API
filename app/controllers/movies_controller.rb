class MoviesController < ApplicationController
  def index
    data = Movie.all
    render status: :ok, json: data.as_json(only: [:title, :release_date])
  end

  def show
  end
end
