require 'nokogiri'

class Post
  attr_reader :title, :url, :points, :item_id, :comments
  def initialize(title, url, points, item_id, comments)
    @title, @url, @points, @item_id, @comments = title, url, points, item_id, comments
  end
end