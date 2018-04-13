require_relative 'url'

class Article
  def initialize(td)
    @td = td
  end

  def title
    @title ||= link.text.tr('’', "'")
  end

  def url
    @url ||= Url.new(link['href'])
  end

  def sponsored?
    @td.css('.tag-sponsor').any?
  end

  private

  def link
    @link ||= @td.css('.mainlink a').first
  end
end
