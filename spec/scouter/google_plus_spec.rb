require 'spec_helper'

describe Scouter::GooglePlus do
  describe '#get_count' do
    let!(:yahoo) { 'http://www.yahoo.co.jp/' }
    let!(:google) { 'http://www.google.com/' }

    context 'when url parameter is String' do
      it 'yahoo has over 130000 count' do
        results, errors = Scouter::GooglePlus.get_count(yahoo)
        expect(errors).to be_empty
        expect(results[yahoo].googleplus).to be >= 130000

      end
    end

    context 'when url parameter is Array' do
      it 'yahoo has over 130000 count and google has over 9100000 count' do
        results, errors = Scouter::GooglePlus.get_count([google, yahoo])
        expect(errors).to be_empty
        expect(results[yahoo].googleplus).to be >= 130000
        expect(results[google].googleplus).to be >= 9100000
      end
    end
  end

end
