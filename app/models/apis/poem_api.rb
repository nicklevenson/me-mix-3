class PoemApi
  def scrape_poems(query)
    base =  "https://www.poetryfoundation.org"
    search_url = "https://www.poetryfoundation.org/search?query=#{query}&refinement=poems"
    html = URI.open(search_url)
    doc = Nokogiri::HTML(html)
    headings = (doc.css('.c-feature'))[0..19]
    poems = []
    headings.each do |heading|
      title = heading.css('.c-feature-hd').text.split(" ").join(" ")
      author = heading.css('.c-feature-sub').css('span').children.text
      url = (heading.css('h2').css('a').collect{|link| link.attribute('href').value})[0]
      if url != nil
        link = base + url
        poems << {data_type: "poem", title: title, creators: [author], url: link}
      end   
    end
    poems

  end
end