require 'spec_helper'

describe Scouter::Buffer do
  describe '#get_count' do
    let!(:yahoo) { 'http://www.yahoo.co.jp/' }
    let!(:google) { 'http://www.google.com/' }

    context 'when url parameter is String' do
      context 'when url is feed url' do
        it 'return 129 shares' do
          results, errors = Scouter::Buffer.get_count(yahoo)
          expect(errors).to be_empty
          expect(results[yahoo].buffer).to be == 129
        end
      end
    end

    context 'when url parameter is Array' do
      it 'yahoo has over 129 shares and google 4635 shares' do
        results, errors = Scouter::Buffer.get_count([yahoo, google])
        expect(errors).to be_empty
        expect(results[yahoo].buffer).to be == 129
        expect(results[google].buffer).to be == 4635
      end
    end
  end

end
