# frozen_string_literal: true

require_relative 'url'

class Article
  def initialize(td_tag)
    @td_tag = td_tag
  end

  def title
    @title ||= link.text.tr('’', "'")
  end

  def url
    @url ||= Url.new(link['href'])
  end

  def sponsored?
    @td_tag.css('.tag-sponsor').any?
  end

  private

  def link
    @link ||= @td_tag.css('.mainlink a').first
  end
end
