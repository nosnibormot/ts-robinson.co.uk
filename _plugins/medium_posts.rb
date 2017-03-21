require 'feedjira'

def rss_parser(url)
  Feedjira::Feed.fetch_and_parse(url).entries.each do |e|
    p "Title: #{e.title}, published on Medium #{e.url}"
  end
end


rss_parser("https://medium.com/feed/@tomrobinson_33099")
