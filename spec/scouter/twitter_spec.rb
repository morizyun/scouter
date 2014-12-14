require 'spec_helper'

describe Scouter::Twitter do
  describe '#get_count' do
    let!(:yahoo) { 'http://www.yahoo.co.jp/' }
    let!(:google) { 'http://www.google.com/' }

    context 'when url parameter is String' do
      it 'yahoo has over 135000 tweet' do
        results, errors = Scouter::Twitter.get_count(yahoo)
        expect(errors).to be_empty
        expect(results[yahoo].twitter).to be >= 135000
      end
    end

    context 'when url parameter is Array' do
      it 'yahoo has over 135000 tweet and google has over 21920000 tweet' do
        results, errors = Scouter::Twitter.get_count([google, yahoo])
        expect(errors).to be_empty
        expect(results[yahoo].twitter).to be >= 135000
        expect(results[google].twitter).to be >= 21920000
      end
    end
  end

end
