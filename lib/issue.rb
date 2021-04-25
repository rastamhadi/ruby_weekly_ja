# frozen_string_literal: true

require 'httparty'
require 'nokogiri'
require 'erb'
require 'pathname'
require_relative 'article'
require_relative 'category'

class Issue
  attr_reader :number

  def initialize(number)
    @number = number
  end

  def highlights
    article_chunks.first
  end

  def categories
    article_chunks[1..].each_slice(2).map do |categories, articles|
      categories.first.tap { |c| c.articles = articles }
    end
  end

  def markdown
    ERB.new(File.read(markdown_template), trim_mode: '<>').result(binding)
  end

  private

  def article_chunks
    @article_chunks ||= articles_and_categories.chunk(&:class).map(&:last)
  end

  def articles_and_categories
    dom.css('.el-heading td, .item td').map do |td|
      td.css('.mainlink').any? ? Article.new(td) : Category.new(td)
    end
  end

  def markdown_template
    Pathname.new(__dir__).join('issue.md.erb')
  end

  def dom
    @dom ||= Nokogiri::HTML(html)
  end

  def html
    HTTParty.get(url).body
  end

  def url
    @url ||= "http://rubyweekly.com/issues/#{number}"
  end
end
