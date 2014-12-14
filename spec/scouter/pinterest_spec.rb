require 'spec_helper'

describe Scouter::Pinterest do
  describe '#get_count' do
    let!(:yahoo) { 'http://www.yahoo.co.jp/' }
    let!(:google) { 'http://www.google.com/' }

    context 'when url parameter is String' do
      it 'yahoo has over 141 pins' do
        results, errors = Scouter::Pinterest.get_count(yahoo)
        expect(errors).to be_empty
        expect(results[yahoo].pinterest).to be >= 141
      end
    end

    context 'when url parameter is Array' do
      it 'yahoo has over 141 pins and google has over 912822 pins' do
        results, errors = Scouter::Pinterest.get_count([google, yahoo])
        expect(errors).to be_empty
        expect(results[yahoo].pinterest).to be >= 141
        expect(results[google].pinterest).to be >= 912822
      end
    end
  end

end
