require 'spec_helper'

describe Scouter::Feedly do
  describe '#get_count' do
    let!(:morizyun_hp)  { 'http://morizyun.github.io' }
    let!(:morizyun_feed){ 'http://feeds.feedburner.com/rubyrails' }
    let!(:yahoo_news)   { 'http://rss.dailynews.yahoo.co.jp/fc/rss.xml' }

    context 'when url parameter is String' do
      context 'when url is feed url' do
        it 'return 699 subscriber' do
          results, errors = Scouter::Feedly.get_count(morizyun_feed)
          expect(errors).to be_empty
          expect(results[morizyun_feed].feedly).to be >= 699
        end
      end

      context 'when url is website url' do
        it 'return nil' do
          results, errors = Scouter::Feedly.get_count(morizyun_hp)
          expect(errors).to be_empty
          expect(results[morizyun_hp]).to be_nil
        end
      end
    end

    context 'when url parameter is Array' do
      it 'morizyun.github.io has over 699 subscriber and google has over 4369 subscriber' do
        results, errors = Scouter::Feedly.get_count([morizyun_feed, yahoo_news])
        expect(errors).to be_empty
        expect(results[morizyun_feed].feedly).to be >= 699
        expect(results[yahoo_news].feedly).to be >= 4369
      end
    end
  end

end
