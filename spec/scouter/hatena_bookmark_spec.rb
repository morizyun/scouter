require 'spec_helper'

describe Scouter::HatenaBookmark do
  describe '#get_count' do
    let!(:yahoo) { 'http://www.yahoo.co.jp/' }
    let!(:google) { 'http://www.google.com/' }

    context 'when url parameter is String' do
      it 'yahoo has over 13000 bookmarks' do
        results, errors = Scouter::HatenaBookmark.get_count(yahoo)
        expect(errors).to be_empty
        expect(results[yahoo].hatenabookmark).to be >= 13000

      end
    end

    context 'when url parameter is Array' do
      it 'yahoo has over 13000 bookmarks and google has over 450 bookmarks' do
        results, errors = Scouter::HatenaBookmark.get_count([google, yahoo])
        expect(errors).to be_empty
        expect(results[yahoo].hatenabookmark).to be >= 13000
        expect(results[google].hatenabookmark).to be >= 450
      end
    end
  end

end
