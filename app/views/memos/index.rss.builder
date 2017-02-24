xml.instruct! :xml, :version => "1.0"
xml.rss("version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/") do
  xml.channel do
    xml.title "User's posts"

    @memos.each do |memo|
      xml.item do
        xml.title memo.title
        xml.description memo.description
        xml.pubDate memo.created_at.in_time_zone('UTC').to_s(:rfc822)
        xml.guid "http://#{request.host_with_port}/memos/#{memo.id}"
        xml.link "http://#{request.host_with_port}/memos/#{memo.id}"
      end
    end
  end
end
