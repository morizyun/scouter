require 'spec_helper'

describe Scouter::Pocket do
  describe '#get_count' do
    let!(:yahoo) { 'http://www.yahoo.co.jp/' }
    let!(:google) { 'http://www.google.com/' }

    context 'when url parameter is String' do
      it 'yahoo has over 22000 like' do
        results, errors = Scouter::Pocket.get_count(yahoo)
        expect(errors).to be_empty
        expect(results[yahoo].pocket).to be >= 22000
      end
    end

    context 'when url parameter is Array' do
      it 'yahoo has over 22000 count and google has over 160000 count' do
        results, errors = Scouter::Pocket.get_count([google, yahoo])
        expect(errors).to be_empty
        expect(results[yahoo].pocket).to be >= 22000
        expect(results[google].pocket).to be >= 160000
      end
    end
  end

end
