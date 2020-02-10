# frozen_string_literal: true

require 'nokogiri'
require 'article'

RSpec.describe Article do
  let(:sponsored_tag) do
    Nokogiri::HTML.fragment(<<~HTML.strip)
      <td >
        <a href="https://rubyweekly.com/link/83503/web"><img src="https://copm.s3.amazonaws.com/43abf35c.png" class="som"></a>
        <p class="desc"><span class="mainlink"><a href="https://rubyweekly.com/link/83503/web">Because Reading Error Logs Is Not a Hobby</a></span> — What would you do with more time in your day? Honeybadger combines uptime, check-in, and error monitoring so you can spend less time debugging and more time doing what you actually love. Reclaim your time by <a href="https://rubyweekly.com/link/83503/web" >clicking here</a>.</p>
        <p class="name">Honeybadger <span class="tag-sponsor">sponsor</span></p>
      </td>
    HTML
  end
  let(:unsponsored_tag) do
    Nokogiri::HTML.fragment(<<~HTML.strip)
      <td>
        <p class="desc">
          <span class="mainlink"><a href="https://rubyweekly.com/link/83501/web">Exploring Big-O Notation with Ruby</a></span> — ‘Big O’ notation is used to express algorithmic complexity and it’s a handy concept to know as a developer (and not only for job&nbsp;interviews).
        </p>
        <p class="name">Honeybadger Developer Blog </p>
      </td>
    HTML
  end
  let(:sponsored_article) { Article.new(sponsored_tag) }
  let(:unsponsored_article) { Article.new(unsponsored_tag) }

  describe '#title' do
    specify do
      expect(unsponsored_article.title).to eq 'Exploring Big-O Notation with Ruby'
    end
  end

  describe '#url' do
    specify do
      expect(unsponsored_article.url).to be_a Url
      expect(unsponsored_article.url.to_s).to eq 'https://rubyweekly.com/link/83501/web'
    end
  end

  describe '#sponsored?' do
    specify do
      expect(sponsored_article).to be_sponsored
      expect(unsponsored_article).not_to be_sponsored
    end
  end
end
