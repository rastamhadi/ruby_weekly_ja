# frozen_string_literal: true

require 'issue'

RSpec.describe Issue do
  let(:issue) { Issue.new(549) }

  describe '#highlights' do
    specify do
      VCR.use_cassette(:issue) do
        highlights = issue.highlights

        expect(highlights.size).to eq 5
        expect(highlights).to all(be_an Article)
        expect(highlights.map(&:title)).to eq [
          'Why Our Puma Workers Constantly Hung, and How We Fixed It by Discovering a Bug of Ruby 2.5.8 and 2.6.6',
          'Bundler 2.2.3+ and the Deployment of Ruby Apps',
          'On Heroku? Try Autoscaling the Rails Way',
          'Solidus v3.0 Released: A Rails-Based Ecommerce Platform',
          'How to Build An App, Get Acquired by GitHub, Buy An App Back From GitHub and Then Sell It Again'
        ]
      end
    end
  end

  describe '#categories' do
    specify do
      VCR.use_cassette(:issue) do
        categories = issue.categories

        expect(categories.size).to eq 2
        expect(categories).to all(be_a Category)
        expect(categories.map(&:name)).to eq [
          'Articles & Tutorials',
          'Code and Tools'
        ]
        categories.each do |category|
          expect(category.articles).to all(be_an Article)
        end
      end
    end
  end

  describe '#markdown' do
    specify do
      VCR.use_cassette(:issue) do
        markdown_lines = issue.markdown.strip.lines.map(&:strip)

        expect(markdown_lines.first).to eq '[http://rubyweekly.com/issues/549:embed:cite]'
        expect(markdown_lines.last).to start_with '> [acts_as_list 1.0.4: An ActiveRecord Plugin for Managing Lists](https://rubyweekly.com/link/106780/web)'
      end
    end
  end
end
