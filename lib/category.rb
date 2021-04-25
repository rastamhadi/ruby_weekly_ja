# frozen_string_literal: true

class Category
  attr_accessor :articles

  def initialize(td_tag)
    @p = td_tag.css('p')
  end

  def name
    @name ||= @p.text.tr('^A-Za-z& ', '').strip
  end
end
