# frozen_string_literal: true

require 'nokogiri'
require 'category'

RSpec.describe Category do
  let(:articles_tag) { Nokogiri::HTML.fragment('<td><p>📘 Articles &amp; Tutorials </p></td>') }
  let(:code_tag) { Nokogiri::HTML.fragment('<td><p>🛠&nbsp;Code and Tools</p></td>') }
  let(:articles_category) { Category.new(articles_tag) }
  let(:code_category) { Category.new(code_tag) }

  describe '#name' do
    specify do
      expect(articles_category.name).to eq 'Articles & Tutorials'
      expect(code_category.name).to eq 'Code and Tools'
    end
  end
end
