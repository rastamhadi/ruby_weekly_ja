# frozen_string_literal: true

require 'issue'

RSpec.describe Issue do
  let(:issue) { Issue.new(487) }

  describe '#highlights' do
    specify do
      VCR.use_cassette(:issue) do
        highlights = issue.highlights

        expect(highlights.size).to eq 5
        expect(highlights).to all(be_an Article)
        expect(highlights.map(&:title)).to eq [
          'An Interview with David Heinemeier Hansson, the Software Contrarian',
          'Exploring Big-O Notation with Ruby',
          'Because Reading Error Logs Is Not a Hobby',
          'Error Handling with Monads in Ruby',
          'The Missing Semester of Your CS Education'
        ]
      end
    end
  end

  describe '#categories' do
    specify do
      VCR.use_cassette(:issue) do
        categories = issue.categories

        expect(categories.size).to eq 3
        expect(categories).to all(be_a Category)
        expect(categories.map(&:name)).to eq [
          'Jobs',
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

        expect(markdown_lines.first).to eq '[http://rubyweekly.com/issues/487:embed:cite]'
        expect(markdown_lines.last).to start_with '> [ParallelTests: 2 CPUs = 2x Testing Speed for RSpec, Test::Unit and Cucumber](https://rubyweekly.com/link/83547/web)'
      end
    end
  end
end
