module ShopSensor
  class Configuration
    Config = Struct.new 'Config', :api_key

    DEFAULTS = {}

    def initialize settings={}
      @config = Config.new
      set settings
    end

    def configure &block
      block.call @config
      self
    end

    def clear!
      set DEFAULTS
    end

    private
    def method_missing method, *args
      return super unless @config.members.include? method
      @config.public_send method, *args
    end

    def set settings={}
      @config.members.each { |member| @config[member] = settings[member] }
    end
  end
end
