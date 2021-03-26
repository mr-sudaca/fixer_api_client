require 'json'
require 'time'

module FixerApiClient
  class CurrencyData

    def self.rates
      new.rates
    end

    def self.symbols
      new.symbols
    end

    def self.rates_creation_date
      new.rates_creation_date
    end

    def rates_creation_date
      timestamp = parse(rates_filename, 'rates')['timestamp']
      timestamp && Time.strptime(timestamp.to_s,'%s').utc.to_s
    end

    def rates
      @rates ||= parse(rates_filename, 'rates')['rates']
    end

    def symbols
      @symbols ||= parse(currencies_filename, 'symbols')['symbols']
    end

    private 

    def parse(filename, data_path)
      data = 
        if update?(filename)
          results = connection.get("#{url_for(data_path)}?access_key=#{api_key}")
          if results.status == 200
            file = File.open(filename, 'w')
            file.puts(results.body.to_json) 
            file.close
            results.body.to_json
          else
            File.read(filename)
          end
        else
          File.read(filename)
        end

      JSON.parse(data)
    end

    def url_for(path)
      case path
      when 'rates' then '/latest'
      when 'symbols' then '/symbols'
      end
    end

    def update?(filename)
      return false if tests?
      return false unless File.exists?(filename) && !File.zero?(filename)
      return false if filename =~ /currency_symbols/ # currency symbols file doesn't have timestamp...

      data = File.read(filename)
      json = JSON.parse(data)
      ((Time.now.utc - Time.at(json['timestamp']).utc) / 60 / 60) > 24
    end

    def tests?
      ENV['fixer_api_client_tests'].to_s == 'true'
    end

    def rates_filename
      @rates_filename ||= 
        File.join(File.dirname(__dir__), 'data', env,'rates_data.json')
    end
    
    def env
      tests? ? 'test' : 'production'
    end

    def currencies_filename
      @currencies_filename ||= 
        File.join(File.dirname(__dir__), 'data', env, 'currency_symbols.json')
    end

    def connection
      @connection ||= FixerApiClient::Connection.connection
    end

    def api_key
      raise 'You need an api key' unless ENV['FIXER_IO_API_KEY'] 

      ENV['FIXER_IO_API_KEY']
    end
  end
end
