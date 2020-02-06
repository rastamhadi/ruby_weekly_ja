# frozen_string_literal: true

require 'url'

RSpec.describe Url do
  describe '#to_s' do
    specify do
      url = Url.new('https://rubyweekly.com/link/78929/web')

      expect(url.to_s).to eq 'https://rubyweekly.com/link/78929/web'
    end
  end

  describe '#redirected_url' do
    specify do
      url = Url.new('https://rubyweekly.com/link/78929/web')

      VCR.use_cassette('redirected_url') do
        redirected_url = url.redirected_url

        expect(redirected_url).to be_a Url
        expect(redirected_url.to_s).to eq 'https://www.ruby-lang.org/en/news/2019/10/22/ruby-2-7-0-preview2-released/'
      end
    end
  end
end
