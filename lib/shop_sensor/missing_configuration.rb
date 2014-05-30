module ShopSensor
  class MissingConfiguration < StandardError
    def initialize *keys
      super
      @keys = keys
    end

    def message
      "Missing configuration. [#{@keys.map(&:inspect).join(', ')}]"
    end
  end
end
