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
        title = e[:title]
        content = e[:content]
        guid = e[:url]
        puts "---------JUNK PRINTING----------"
        puts "#{title}, #{content}, #{guid}"
        path = "./_external_feed/" + title + ".md"
        path = site.in_source_dir(path)
        doc = Jekyll::Document.new(path, { :site => site, :collection => jekyll_coll })
        puts "---------JUNK PRINTING AGAIN----------"
        puts "JEKYLCOLL----#{jekyll_coll}"
        puts "#{site.collections['external_feed']}"
        puts "#{doc.collection}"
        puts "DOCDATA--------_!!!!!!"
        doc.data['title'] = title;
        doc.data['feed_content'] = content;
        puts "DOC----#{doc.data}"
        puts "HEEEELLLOOOOOO"
        puts "#{jekyll_coll.docs}"
        jekyll_coll.docs << doc
        puts "GOODBYEEEEEEE"
        puts "#{jekyll_coll.docs}"
        puts "DOC----#{doc}"
        puts "JEKYLCOLL----#{jekyll_coll}"
        puts "#{jekyll_coll.docs}"
      end

      puts "----------SITE COLLECTION THING-------"
      puts "#{site.collections}"
      puts "#{site.collections['external_feed'].docs}"

    end
  end
end
