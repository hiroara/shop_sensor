module ShopSensor
  class Client
    attr_accessor :configuration

    def initialize
      @configuration = ShopSensor.configuration
    end

    def request endpoint
      raise ShopSensor::MissingConfiguration, :api_key unless @configuration.api_key
    end
  end
end
