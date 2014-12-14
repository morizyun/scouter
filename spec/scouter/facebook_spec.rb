require 'spec_helper'

describe Scouter::Facebook do
  describe '#get_count' do
    let!(:yahoo) { 'http://www.yahoo.co.jp/' }
    let!(:google) { 'http://www.google.com/' }

    context 'when url parameter is String' do
      context 'when exist url' do
        it 'yahoo has over 160000 like' do
          results, errors = Scouter::Facebook.get_count(yahoo)
          expect(errors).to be_empty
          expect(results[yahoo].facebook).to be >= 160000
        end
      end

      context 'when raise parse errors' do
        it 'returns error' do
          allow(Scouter::Facebook).to receive(:parse_response).and_raise(StandardError)
          _, errors = Scouter::Facebook.get_count(yahoo)
          expect(errors).not_to be_empty
        end
      end
    end

    context 'when url parameter is Array' do
      it 'yahoo has over 160000 like and google has over 9900000 like' do
        results, errors = Scouter::Facebook.get_count([yahoo, google])
        expect(errors).to be_empty
        expect(results[yahoo].facebook).to be >= 160000
        expect(results[google].facebook).to be >= 9900000
      end
    end
  end

end
