require 'feedjira'

url = "https://medium.com/feed/@tomrobinson_33099"
feed = Feedjira::Feed.fetch_and_parse url

puts "#{feed.title}"
puts "#{feed.url}"
puts "#{feed.entries.first.title}"
