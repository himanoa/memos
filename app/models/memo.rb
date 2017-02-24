require('redcarpet')
require('gemoji')
class Memo < ApplicationRecord
  belongs_to :user
  def rendered_body
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(filter_html: true),
                                          { autolink: true, strikethrough: true })
    @rendered_body ||= emojinize(@markdown.render(body))
  end

  private
    def emojinize(text)
      text.gsub(/:([\w+-]+):/) do |match|
        p $1
        if emoji = Emoji.find_by_alias($1)
          emoji.raw
        else
          match
        end
      end
    end
end
