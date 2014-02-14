class EmailParser

  def initialize(message)
    @message = message
  end

  def user_email
    @message.from
  end

  def tags
    tags_array = @message.subject.split(/\W+/)
    tags_array .join(" ")
  end

  def url 
    decoded_body = nil
    @message.parts.each do |part| 
      if part.content_type.start_with?("text/plain")
        decoded_body = part.decode_body 
      else
        decoded_body = @message.body.decoded
      end
    end
    url = /\b(([\w-]+:\/\/?|www[.])[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:<>"]\s]|\/)))/.match(decoded_body)
    url[0]
  end
end
