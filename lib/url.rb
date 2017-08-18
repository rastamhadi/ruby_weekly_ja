require 'active_support/core_ext/object/try'

class Url
  def initialize(url)
    @url = url
  end

  def to_s
    uri.to_s
  end

  private

  def uri
    @uri ||= begin
      uri = URI(@url)
      if uri.query
        sanitized_query = URI.decode_www_form(uri.query).reject { |k, _| k.start_with? 'utm_' }
        uri.query = sanitized_query.empty? ? nil : URI.encode_www_form(sanitized_query)
      end
      uri
    end
  end
end
