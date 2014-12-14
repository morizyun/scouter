require 'spec_helper'

describe Scouter do
  it 'has a version number' do
    expect(Scouter::VERSION).not_to be nil
  end

  describe '#get_count' do
    let!(:yahoo) { 'http://www.yahoo.co.jp/' }
    let!(:google) { 'http://www.google.com/' }
    let!(:morizyun_feed) { 'http://feeds.feedburner.com/rubyrails' }
    let!(:morizyun_hp) { 'http://morizyun.github.io' }

    context 'when url parameter is String' do
      context 'when get count by all services' do
        it 'returns all social count info by 1 url' do
          results, errors = Scouter.get_count(yahoo)

          expect(errors).to be_empty

          expect(results[yahoo].buffer).to          be == 129
          expect(results[yahoo].facebook).to        be >= 160000
          expect(results[yahoo].googleplus).to      be >= 130000
          expect(results[yahoo].hatenabookmark).to  be >= 13000
          expect(results[yahoo].linkedin).to        be >= 216
          expect(results[yahoo].pinterest).to       be >= 141
          expect(results[yahoo].pocket).to          be >= 22000
          expect(results[yahoo].twitter).to         be >= 135000
        end
      end

      context 'when get count by twitter/facebook' do
        let!(:services) { [Scouter::Facebook, Scouter::Twitter] }
        it 'returns many social count info by 1 url' do
          results, errors = Scouter.get_count(yahoo, services)
          expect(errors).to be_empty
          expect(results[yahoo].facebook).to        be >= 160000
          expect(results[yahoo].twitter).to         be >= 135000
        end
      end
    end

    context 'when url parameter is Array' do
      context 'when get count by all services' do
        it 'returns all social count info by 2 urls' do
          results, errors = Scouter.get_count([google, yahoo])
          expect(errors).to be_empty

          expect(results[yahoo].buffer).to            be == 129
          expect(results[yahoo].facebook).to          be >= 160000
          expect(results[yahoo].googleplus).to        be >= 130000
          expect(results[yahoo].hatenabookmark).to    be >= 13000
          expect(results[yahoo].linkedin).to          be >= 216
          expect(results[yahoo].pinterest).to         be >= 141
          expect(results[yahoo].pocket).to            be >= 22000
          expect(results[yahoo].twitter).to           be >= 135000

          expect(results[google].buffer).to           be == 4635
          expect(results[google].facebook).to         be >= 9900000
          expect(results[google].googleplus).to       be >= 9100000
          expect(results[google].hatenabookmark).to   be >= 450
          expect(results[google].linkedin).to         be >= 1003
          expect(results[google].pinterest).to        be >= 912822
          expect(results[google].pocket).to           be >= 160000
          expect(results[google].twitter).to          be >= 21920000
        end
      end

      context 'when get count by feedly/pocket' do
        let!(:services) { [Scouter::Feedly, Scouter::Pocket] }
        it 'returns many social count info by 1 url' do
          results, errors = Scouter.get_count([morizyun_feed, morizyun_hp], services)
          expect(errors).to be_empty
          expect(results[morizyun_feed].feedly).to  be == 699
          expect(results[morizyun_hp].pocket).to    be == 39
        end
      end

    end
  end

end
