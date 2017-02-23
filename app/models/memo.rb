require('redcarpet')
class Memo < ApplicationRecord
  belongs_to :user
  def rendered_body
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(filter_html: true),
                                          { autolink: true, strikethrough: true })
    @rendered_body ||= @markdown.render(body)
  end
end
