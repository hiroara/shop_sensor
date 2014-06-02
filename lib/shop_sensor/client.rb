require 'faraday'

module ShopSensor
  class Client
    attr_accessor :configuration

    API_VERSION = 'v2'
    API_ROOT_PATH = '/api'
    API_HOST = "http://api.shopstyle.com"

    def initialize
      @configuration = ShopSensor.configuration.clone
    end

    def get endpoint, options={}
      response = self.request endpoint, options
      JSON.parse response.body
    end

    def request endpoint, options={}
      raise ShopSensor::MissingConfiguration, :api_key unless @configuration.api_key
      options[:format] ||= 'json'
      path = File.join API_ROOT_PATH, API_VERSION, endpoint
      connection.get path, options
    end

    def product prod_id
      self.get "/products/#{prod_id}"
    end

    def configure &block
      @connection = nil
      @configuration.configure &block
    end

    private
    def connection
      @connection ||= Faraday.new(API_HOST, params: default_params) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end

    def default_params
      { pid: configuration.api_key, site: configuration.site }
    end

    def method_missing method, *args
      return super unless simple_apis.include? method.to_s
      get *([method.to_s] + args)
    end

    def simple_apis
      [
        'brands',
        'products',
        'categories',
        'colors',
        'retailers'
      ]
    end
  end
end
