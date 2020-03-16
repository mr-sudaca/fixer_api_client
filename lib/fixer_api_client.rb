require "fixer_api_client/version"

module FixerApiClient
  class Error < StandardError; end

  def self.available_conversions
    FixerApiClient::CurrencyData.symbols.map do |symbol, _|
      "to_#{symbol.downcase}"
    end
  end

  def self.available_currencies
    FixerApiClient::CurrencyData.symbols.map do |symbol, friendly_name|
      "#{symbol.downcase}: #{friendly_name}"
    end
  end

  def self.rates_creation_date
    FixerApiClient::CurrencyData.rates_creation_date
  end

  require 'fixer_api_client/connection'
  require 'fixer_api_client/currency_data'
  require 'fixer_api_client/numeric_overloader'
  require 'fixer_api_client/currency'

end
