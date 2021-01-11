require 'spec_helper'

describe FixerApiClient::Currency do
  context 'conversion methods' do
    describe '#to_{currency}' do
      it 'converts value to given currency' do
        currency = described_class.new(1, 'usd', 'usd currency')
        expect(currency.to_cop.inspect).to eq('4126.64 Colombian Peso')

        currency = described_class.new(3, 'eur', 'eur currency')
        expect(currency.to_ars.inspect).to eq('207.16 Argentine Peso')
      end
    end
  end
end
