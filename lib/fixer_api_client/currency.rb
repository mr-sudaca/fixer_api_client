
module FixerApiClient
  class Currency
    BASE_CURRENCY = 'EUR'
    BASE_CURRENCY_AMOUNT = 1

    attr_reader :value, :symbol, :friendly_name

    def initialize(value, symbol, friendly_name)
      @value = value
      @symbol = symbol
      @friendly_name = friendly_name

    end

    def inspect
      "#{value} #{friendly_name}"
    end

    FixerApiClient::CurrencyData.symbols.each do |symbol, friendly_name|
      define_method "to_#{symbol.downcase}" do
        new_value = 
          (to_base * currency_rates[symbol.upcase]).round(2)

        self.class.new(new_value, symbol.downcase, friendly_name)
      end
    end

    ['+', '-', '*', '/'].each do |operator|
      define_method operator do |other_value|
        new_value = value.public_send(operator, other_value)
        self.class.new(new_value, symbol, friendly_name)
      end
    end

    private

    # this will convert the value we have to the base currency (EUR) because
    # API free tier only allows to set EUR as base, so, let's say we have 
    # 1 USD, this, will convert it to 0.80 EUR
    def to_base
      value / current_rate
    end

    def current_rate
      currency_rates[symbol.upcase]
    end
    
    def currency_rates
      @currency_rates ||= FixerApiClient::CurrencyData.rates
    end
  end
end
