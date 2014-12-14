require 'spec_helper'

describe Scouter::Linkedin do
  describe '#get_count' do
    let!(:yahoo) { 'http://www.yahoo.co.jp/' }
    let!(:google) { 'http://www.google.com/' }

    context 'when url parameter is String' do
      it 'yahoo has over 216 count' do
        results, errors = Scouter::Linkedin.get_count(yahoo)
        expect(errors).to be_empty
        expect(results[yahoo].linkedin).to be >= 216
      end
    end

    context 'when url parameter is Array' do
      it 'yahoo has over 216 count and google has over 1003 count' do
        results, errors = Scouter::Linkedin.get_count([google, yahoo])
        expect(errors).to be_empty
        expect(results[yahoo].linkedin).to be >= 216
        expect(results[google].linkedin).to be >= 1003
      end
    end
  end

end
