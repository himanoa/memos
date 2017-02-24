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
  def rendered_body
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(filter_html: true),
                                          { autolink: true, strikethrough: true })
    @rendered_body ||= self.emojify(@markdown.render(body))
  end
end
