class StatusDecorator < ApplicationDecorator
  delegate_all

  delegate :screen_name, to: :user
  delegate :link_to, to: :h

  def to_s
    "#{screen_name_link}: #{built_text}".html_safe
  end

  def screen_name_link(name = screen_name)
    link_to "@#{name}", "https://twitter.com/#{name}"
  end

  def built_text
    @built_text ||= text_with_hashtags
  end

  private

  def twitter_link(name = nil, path)
    name ||= path
    link_to name, "https://twitter.com/#{path}"
  end

  def text_with_hashtags
    hashtags.reduce(text_with_users) do |str, hash_entity|
      str.gsub(
        "##{hash_entity.text}",
        twitter_link("##{hash_entity.text}")
      )
    end
  end

  def text_with_users
    user_mentions.reduce(text_with_links) do |str, mention_entity|
      str.gsub(
        "@#{mention_entity.screen_name}",
        screen_name_link(mention_entity.screen_name)
      )
    end
  end

  def text_with_links
    urls.reduce(full_text) do |str, url_entity|
      str.gsub(url_entity.url, link_to(url_entity.display_url, url_entity.url))
    end
  end
end
