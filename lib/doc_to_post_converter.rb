require 'open-uri'

class DocToPostConverter

  def convert(doc)
    raise 'URL must be from Hacker News' unless /news.ycombinator.com/.match(doc)
    doc = Nokogiri::HTML(File.open(open(doc)))
    @title_block = doc.search('.title > a')
    Post.new(extract_title(doc), extract_url(doc), extract_points(doc), extract_item_id(doc), add_comment(doc))
  end

  def extract_title(doc)
    @title_block.map {|element| element.inner_text }
  end

  def extract_url(doc)
    @title_block.map {|element| element }[0].to_s.scan(/http.*\"/)[0].gsub("\"","")
  end

  def extract_points(doc)
    doc.search('.score').map {|element| element.inner_text }[0]
  end

  def extract_item_id(doc)
    doc.search('.age > a:first-child').map {|element| element }[0].to_s.scan(/\d{8}+/)
  end

  def add_comment(doc)
    user = doc.search('.comhead > a:first-child').map {|element| element.inner_text}
    text = doc.search('.default > .comment > span').map {|element| element.inner_text.to_s.gsub(/\s{5}+reply/, "").strip}
    time = doc.search('.age').map {|element| element.inner_text}
    counter, comment = 0, []
    until counter > user.size 
      comment << Comment.new(user[counter+1],text[counter],time[counter]) if user[counter+1] || text[counter] || time[counter] == (nil||"") 
      counter += 1
    end
    comment
  end


end