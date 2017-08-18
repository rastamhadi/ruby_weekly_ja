require 'active_support/core_ext/object/try'
require 'active_support/core_ext/string/inflections'
require_relative 'url'

class Article
  def initialize(li)
    @li = li
  end

  def title
    @title ||= link.text
  end

  def url
    @url ||= Url.new(link['href'])
  end

  def category
    return @category if defined? @category
    tag = @li.css('span').find { |span| span['style'] =~ /color: #fff/ }
    @category = tag.try(:text)
  end

  private

  def link
    @link ||= @li.css('a').first
  end
end
