require 'spec_helper'

describe FixerApiClient::Currency do
  context 'conversion methods' do
    describe '#to_{currency}' do
      it 'converts value to given currency' do
        currency = described_class.new(2, 'bar', 'bar currency')
        expect(currency.to_foo.inspect).to eq('4.0 foo currency')

        currency = described_class.new(3, 'foo', 'foo currency')
        expect(currency.to_bar.inspect).to eq('1.5 bar currency')
      end
    end
  end
end
