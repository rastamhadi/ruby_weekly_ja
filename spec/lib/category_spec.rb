# frozen_string_literal: true

require 'nokogiri'
require 'category'

RSpec.describe Category do
  let(:jobs_tag) { Nokogiri::HTML.fragment('<td><p>💻&nbsp;Jobs</p></td>') }
  let(:articles_tag) { Nokogiri::HTML.fragment('<td><p>📘 Articles &amp; Tutorials </p></td>') }
  let(:code_tag) { Nokogiri::HTML.fragment('<td><p>🛠&nbsp;Code and Tools</p></td>') }
  let(:videos_tag) { Nokogiri::HTML.fragment('<td><p>🎥 Videos</p></td>') }
  let(:podcasts_tag) { Nokogiri::HTML.fragment('<td><p>🔈&nbsp;Podcasts</p></td>') }
  let(:jobs_category) { Category.new(jobs_tag) }
  let(:articles_category) { Category.new(articles_tag) }
  let(:code_category) { Category.new(code_tag) }
  let(:videos_category) { Category.new(videos_tag) }
  let(:podcasts_category) { Category.new(podcasts_tag) }

  describe '#jobs?' do
    specify do
      expect(jobs_category).to be_jobs
      expect(articles_category).not_to be_jobs
      expect(code_category).not_to be_jobs
      expect(videos_category).not_to be_jobs
      expect(podcasts_category).not_to be_jobs
    end
  end

  describe '#videos?' do
    specify do
      expect(jobs_category).not_to be_videos
      expect(articles_category).not_to be_videos
      expect(code_category).not_to be_videos
      expect(videos_category).to be_videos
      expect(podcasts_category).not_to be_videos
    end
  end

  describe '#podcasts?' do
    specify do
      expect(jobs_category).not_to be_podcasts
      expect(articles_category).not_to be_podcasts
      expect(code_category).not_to be_podcasts
      expect(videos_category).not_to be_podcasts
      expect(podcasts_category).to be_podcasts
    end
  end

  describe '#name' do
    specify do
      expect(jobs_category.name).to eq 'Jobs'
    end
  end
end
