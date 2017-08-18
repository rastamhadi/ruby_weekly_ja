require 'httparty'
require 'nokogiri'
require 'erb'
require 'pathname'
require_relative 'highlight'
require_relative 'article'

class Issue
  attr_reader :number

  def initialize(number)
    @number = number
  end

  def highlights
    @highlights ||= dom.css(".gowide[width='100%'] [style='font-size: 18px; margin: 2px 0px'] a").map { |h| Highlight.new(h) }
  end

  def articles
    @articles ||= dom.css('ul').last.css('li').map { |a| Article.new(a) }
  end

  def markdown
    ERB.new(File.read(markdown_template), nil, '<>').result(binding)
  end

  private

  def markdown_template
    Pathname.new(__dir__).join('issue.md.erb')
  end

  def dom
    @dom ||= Nokogiri::HTML(html)
  end

  def html
    HTTParty.get(url)
  end

  def url
    @url ||= "http://rubyweekly.com/issues/#{number}"
  end
end
