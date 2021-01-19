class SpotifyApi 

  def fetch_music(query)
    results = RSpotify::Base.search(query, "album,artist,track,playlist", limit:5)
    filtered_data = []
    results.each do |result|
      if result.type == 'album'
        filtered_data << {data_type: "music", title: result.name,creators: result.artists.collect{|c|c.name}, url: result.uri} unless result.album_type == "single" 
      elsif result.type == 'artist'
        filtered_data << {data_type: "music", title: result.name,creators: [result.name], url: result.uri}
      elsif result.type == 'track'
        filtered_data << {data_type: "music", title: result.name,creators: result.artists.collect{|c|c.name}, url: result.uri}
      elsif result.type == 'playlist'
        filtered_data << {data_type: "music", title: result.name,creators: [result.owner.display_name], url: result.uri}
      end
      # byebug
    end
    filtered_data
  end

end
