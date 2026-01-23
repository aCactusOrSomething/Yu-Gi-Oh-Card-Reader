require 'open-uri'

module Attachable
  def attach_file(file_url, association, filename)
    file = URI.open(file_url)
    mime_type = file.content_type
    encoded_file = Base64.strict_encode64(file.read)
    decoded_file = Base64.decode64(encoded_file)
    extension = Rack::Mime::MIME_TYPES.invert[mime_type]

    send(association).attach(
      io: StringIO.new(decoded_file),
      filename: filename + extension,
      content_type: mime_type
    )
  end
end
