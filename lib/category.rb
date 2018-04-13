class Category
  attr_accessor :articles

  def initialize(td)
    @p = td.css('p')
  end

  def jobs?
    name == 'Jobs'
  end

  def videos?
    name == 'Videos'
  end

  def name
    @name ||= @p.text.tr('^A-Za-z& ', '').strip
  end
end
