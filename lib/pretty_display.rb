require 'colorize'
class PrettyDisplay

  def clean(post)
    puts "Title: #{post.title[0].colorize(:light_red)}\nID: #{post.item_id[0].to_i}\nURL: #{post.url.colorize(:blue)}\nPoints: #{post.points}"
    counter = 0
    until counter >= post.comments.length
      puts "#{post.comments[counter].user}: (#{post.comments[counter].time})".colorize(:green)
      puts "#{post.comments[counter].text}\n\n"
      counter += 1
    end
    puts "Total comments: #{post.comments.length.to_s.colorize(:light_red)}"
  end

end