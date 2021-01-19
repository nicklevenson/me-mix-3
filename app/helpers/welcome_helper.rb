module WelcomeHelper
  def filter 
    if params[:query] != ""
      if params[:query] && params[:filter] == "All"
        get_all_results
      elsif params[:query] && params[:filter] == "Mixes"
        get_mixes
      elsif params[:query] && params[:filter] == "Music (Spotify)"
        get_music
      elsif params[:query] && params[:filter] == "Poetry (Poetry Foundation)"
        get_poems
      elsif params[:query] && params[:filter] == "Movies/TV (IMDB)"
        get_movies
      elsif params[:query] && params[:filter] == "Books (Google Books)"
        get_books
      elsif params[:query] && params[:filter] == "Artwork (The Met)"
        get_art
      else
        Mix.all
      end
    else
      Mix.all
    end
  end

  def get_all_results
      q = params[:query]
      @mixes = Mix.where(title: q)
      @songs = SpotifyApi.new.fetch_music(q)
      @poems = PoemApi.new.scrape_poems(q)
      @movies = MovieApi.new.fetch_movies(q)
      @books = GoogleApi.new.fetch_books(q)
      @art = ArtApi.new.fetch_art(q)
      results = @mixes + @songs + @poems + @movies + @books + @art
      results
  end

  def get_mixes
    Mix.where(title: params[:query]) 
  end
  def get_music
    SpotifyApi.new.fetch_music(params[:query])
  end

  def get_poems
    PoemApi.new.scrape_poems(params[:query])
  end

  def get_movies
    MovieApi.new.fetch_movies(params[:query])
  end

  def get_books
    GoogleApi.new.fetch_books(params[:query])
  end

  def get_art
    ArtApi.new.fetch_art(params[:query])
  end

  def render_piece(result)
    if result[:data_type] == "music"
      render partial: "contents/music", locals: {music: result}
    elsif result[:data_type] == "poem"
      render partial: "contents/poem", locals: {poem: result}
    elsif result[:data_type] == "movie"
      render partial: "contents/movie", locals: {movie: result}
    elsif result[:data_type] == "book"
      render partial: "contents/book", locals: {book: result}
    elsif result[:data_type] == "art"
      render partial: "contents/art", locals: {art: result}
    else
      render partial: "mixes/mix", locals: {mix: result}
    end
  end

  def render_result(result)
    if result.respond_to?(:id)
      render partial: 'mixes/mix', locals: {mix: result}
    else
      render partial: 'contents/content', locals: {content: result}
    end
  end
end
