class Comment

  attr_reader :user, :text, :time

  def initialize(user, text, time)
    @user, @text, @time = user, text, time
  end

end