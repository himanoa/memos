require('redcarpet')
require('gemoji')
class Memo < ApplicationRecord
  acts_as_taggable
  belongs_to :user
  def emojify(text)
    text.gsub(/:([\w+-]+):/) do |match|
      p $1
      if emoji = Emoji.find_by_alias($1)
        emoji.raw
      else
        match
      end
    end
  end
  def twitter_hashtagnize(text)
    hash_tag_reg = Regexp.new('#([Ａ-Ｚａ-ｚA-Za-z一-鿆0-9０-９ぁ-ヶｦ-ﾟー]+)')
    text.gsub(hash_tag_reg) { |match| "<a href='https://twitter.com/hashtag/#{$1}'>#{match}</a>" }
  end
  def twitter_mentionize(text)
    text.gsub(/@([a-zA-Z0-9_]{1,15})/){ |match| "<a href='https://twitter.com/#{$1}'>#{match}</a>" }
  end
  def rendered_body
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(filter_html: true),
                                          { autolink: true, strikethrough: true })
    @rendered_body ||= twitter_mentionize(twitter_hashtagnize(emojify(@markdown.render(body))))
  end
end
