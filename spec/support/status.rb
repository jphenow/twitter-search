class Status
  attr_accessor :text
  attr_accessor :screen_name

  alias full_text text

  def user
    OpenStruct.new screen_name: screen_name
  end

  def hashtags
    [
      OpenStruct.new(text: "winning"),
    ]
  end

  def urls
    [
      OpenStruct.new(url: "http://t.co/abc", display_url: "http://google.co.."),
    ]
  end

  def user_mentions
    [
      OpenStruct.new(screen_name: "pbyrne"),
    ]
  end
end
