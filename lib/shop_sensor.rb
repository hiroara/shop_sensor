require "shop_sensor/version"

module ShopSensor
  require 'shop_sensor/client'
  require 'shop_sensor/configuration'
  require 'shop_sensor/missing_configuration'

  module_function
  def configuration
    @@configuration ||= Configuration.new
  end

  def configure &block
    configuration.configure &block
  end
end
