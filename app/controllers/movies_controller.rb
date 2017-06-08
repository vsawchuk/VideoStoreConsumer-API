class MoviesController < ApplicationController
  before_action :require_movie, only: [:show]

  def index
    data = Movie.all
    render status: :ok, json: data.as_json(only: [:title, :release_date])
  end

  def show
    render(
      status: :ok,
      json: @movie.as_json(
        only: [:title, :overview, :release_date, :inventory],
        methods: [:available_inventory]
        )
      )
  end

  def search
    query = params[:query]
    results = MovieWrapper.search(query)

    render status: :ok, json: results
  end

  private

  def require_movie
    @movie = Movie.find_by(title: params[:title])
    unless @movie
      render status: :not_found, json: { errors: { title: ["No movie with title #{params["title"]}"] } }
    end
  end
end
