require 'spec_helper'

describe Scouter::Github do
  describe '#get_count' do
    let!(:yahoo) { 'http://www.yahoo.co.jp/' }
    let!(:morizyun_scouter) { 'https://github.com/morizyun/scouter/' }
    let!(:morizyun_events_jp) { 'https://github.com/morizyun/events_jp' }

    context 'when url parameter is String' do
      context 'when url is github url' do
        it 'return 4 shares' do
          results, errors = Scouter::Github.get_count(morizyun_scouter)
          expect(errors).to be_empty
          expect(results[morizyun_scouter].github).to be == 4
        end
      end

      context 'when url is not github url' do
        it 'return raise error' do
          results, errors = Scouter::Github.get_count(yahoo)
          expect(errors).to be_empty
          expect { results[morizyun_scouter].github }.to raise_error
        end
      end
    end

    context 'when url parameter is Array' do
      it 'morizyun_scouter has over 4 shares and morizyun_events_jp 6 shares' do
        results, errors = Scouter::Github.get_count([morizyun_scouter, morizyun_events_jp, yahoo])
        expect(errors).to be_empty
        expect(results[morizyun_scouter].github).to be == 4
        expect(results[morizyun_events_jp].github).to be == 6
      end
    end
  end

end
