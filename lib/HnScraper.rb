require_relative 'post'
require_relative 'comment'
require_relative 'doc_to_post_converter'
require_relative 'pretty_display'

class HnScraper   
  def self.run(url)
    PrettyDisplay.new.clean(DocToPostConverter.new.convert(url))
  end
end

until /^http.+/.match(ARGV[0])
  puts "Please enter a valid URL."
end 
HnScraper.run(ARGV[0])

# HnScraper.run "https://news.ycombinator.com/item?id=11631157" if $0 == __FILE__
