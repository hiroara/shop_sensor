module ShopSensor
  class Configuration
    Config = Struct.new 'Config', :api_key, :locale

    DEFAULTS = {
      locale: :en_US
    }
    SITES = {
      en_US: 'www.shopstyle.com',
      en_GB: 'www.shopstyle.co.uk',
      fr_FR: 'www.shopstyle.fr',
      de_DE: 'www.shopstyle.de',
      ja_JP: 'www.shopstyle.co.jp',
      en_AU: 'www.shopstyle.com.au',
      en_CA: 'www.shopstyle.ca'
    }

    def initialize settings={}
      @config = Config.new
      set DEFAULTS.merge(settings)
    end

    def configure &block
      block.call @config
      self
    end

    def clear!
      set DEFAULTS
    end

    def site
      SITES[@config.locale.intern]
    end

    def clone
      self.class.new self.to_h
    end

    def to_h
      @config.to_h
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
