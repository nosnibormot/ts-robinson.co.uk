require 'feedjira'
require 'kramdown'
require 'uri'

module Jekyll
  class MediumPostDisplay < Generator
    safe true
    priority :high

    def generate(site)
      jekyll_coll = Jekyll::Collection.new(site, 'external_feed')
      site.collections['external_feed'] = jekyll_coll

      Feedjira::Feed.fetch_and_parse("https://medium.com/feed/@tomrobinson_33099").entries.each do |e|
        p "Title: #{e.title}, published on Medium #{e.url} #{e}"
        title = e.title
        content = e.content
        guid = e.url
        puts "---------JUNK PRINTING----------"
        puts "#{title}, #{content}, #{guid}"
        path = "_rss/" + guid + ".md"
        path = site.in_source_dir(path)
        doc = Jekyll::Document.new(path, { :site => site, :collection => jekyll_coll })
        puts "#{doc}"
        doc.data['title'] = title
        doc.data['feed_content'] = content
        jekyll_coll.docs << doc
        puts "DOC----#{doc}"
        puts "JEKYLCOLL----#{jekyll_coll}"
        puts "DOCDATA---#{doc.data}"
      end

      puts "----------SITE COLLECTION THING-------"
      puts "#{jekyll_coll.docs[0]}"

    end
  end
end
