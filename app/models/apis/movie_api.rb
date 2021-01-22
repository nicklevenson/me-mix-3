class MovieApi
  def fetch_movies(query)
    client = Omdb::Api::Client.new do |config|
      config.api_key = Rails.application.credentials.omdb[:OMDB_API_KEY]
    end
    results = client.search(query)
    movies = []
    if results.respond_to?('each')
      results.each do |movie|
        movies << client.find_by_id(movie.imdb_id)
      end 
    end
    filtered_data = []
    movies.each do |movie|
      filtered_data << {data_type: "movie",
                        title: movie.title, 
                        date: movie.year, 
                        creators: [movie.director], 
                        description: movie.plot, 
                        image: movie.poster, 
                        url: "http://imdb.com/title/#{movie.imdb_id}"}
    end
    filtered_data
  end
end
