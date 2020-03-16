require 'json'
require 'faraday'
require 'faraday_middleware'

module FixerApiClient
  class Connection

    def self.connection
      ::Faraday.new(url: url) do |conn|
        conn.request :json
        conn.adapter :net_http
        conn.response :json, content_type: /\bjson$/
      end
    end

    def self.url
      ENV['FIXER_IO_API_URL'] || 'http://data.fixer.io/api'
    end

  end
end
