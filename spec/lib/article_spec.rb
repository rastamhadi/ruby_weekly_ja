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
  let(:podcast_tag) do
    Nokogiri::HTML.fragment(<<~HTML.strip)
      <td style="font-family: -apple-system,BlinkMacSystemFont,Helvetica,sans-serif; font-size: 15px; line-height: 1.55em; mso-table-lspace: 0pt; mso-table-rspace: 0pt; border-collapse: collapse; padding: 0px 15px;" class="">
        <p class="desc" style="color: #5a5a5a; line-height: 1.45em !important; font-size: 0.9em !important; margin: 8px 0px 6px;"><span style="font-weight: 600; font-size: 1.0em; color: #000;" class="">▶&nbsp;&nbsp;<a target="_blank" href="https://rubyweekly.com/link/106768/web" style="text-decoration: none; color: #0055bb; border-bottom-width: 1px !important; border-bottom-color: #dddddd !important; border-bottom-style: solid !important; font-size: 1.2em !important;" class="">Reducing Friction at the Authorization Layer with John Nunemaker</a></span>
        <br><span class="name" style="color: #5a5a5a; margin-top: 4px; text-transform: uppercase; font-size: 12px; line-height: 2.0em;">Ruby Rogues Podcast</span> <span style="text-transform: uppercase; margin-left: 4px; font-size: 0.9em; border-radius: 2px; padding: 1px 4px; border: 1px solid #999999;" class="tag-podcast">podcast</span>
        </p>
      </td>
    HTML
  end
  let(:normal_tag) do
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
  let(:podcast_article) { Article.new(podcast_tag) }
  let(:normal_article) { Article.new(normal_tag) }

  describe '#title' do
    specify do
      expect(normal_article.title).to eq 'Exploring Big-O Notation with Ruby'
    end
  end

  describe '#url' do
    specify do
      expect(normal_article.url).to be_a Url
      expect(normal_article.url.to_s).to eq 'https://rubyweekly.com/link/83501/web'
    end
  end

  describe '#sponsored?' do
    specify do
      expect(sponsored_article).to be_sponsored
      expect(normal_article).not_to be_sponsored
    end
  end

  describe '#podcast?' do
    specify do
      expect(podcast_article).to be_podcast
      expect(normal_article).not_to be_podcast
    end
  end
end
