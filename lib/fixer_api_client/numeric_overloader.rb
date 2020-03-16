require 'json'

class Numeric
  FixerApiClient::CurrencyData.symbols.each do |symbol, friendly_name|
    define_method symbol.downcase do
      FixerApiClient::Currency.new(self, symbol.downcase, friendly_name)
    end
  end
end
