class MovieWrapper
  BASE_URL = "https://api.themoviedb.org/3/"
  KEY = ENV["MOVIEDB_KEY"]

  DEFAULT_IMG_SIZE = "w185"

  def self.search(query)
    url = BASE_URL + "search/movie?api_key=" + KEY + "&query=" + query
    puts url
    response =  HTTParty.get(url)
    if response["total_results"] == 0
      return []
    else
      movies = response["results"].map do |result|
        Movie.new(title: result["title"], overview: result["overview"], release_date: result["release_date"])
      end
      return movies
    end

    if !response["hits"].empty?
      return response["hits"].map do |recipe|
        Recipe.new(recipe["recipe"]["label"], recipe["recipe"]["uri"].partition("recipe_").last, recipe["recipe"]["image"])
      end
    else
      return []
    end
  end

  private

  def self.construct_image_url(img_name)
    # Call the config endpoint to retrieve the base image url
    config_url = BASE_URL + "configuration?api_key=" + KEY
    config_result = HTTParty.get(config_url)
    base_img_url = config_result["base_url"]

    return base_img_url + DEFAULT_IMG_SIZE + "/" _ img_name
  end

end
