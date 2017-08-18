require_relative 'url'

class Highlight
  def initialize(a)
    @a = a
  end

  def title
    @title ||= @a.text
  end

  def url
    @url ||= Url.new(@a['href'])
  end
end
