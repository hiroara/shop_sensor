require 'spec_helper'

describe ShopSensor::Configuration do
  let(:configuration) { described_class.new }
  let(:api_key) { 'some_api_key' }

  describe :initialize do
    it do
      expect(described_class.new).to be_a ShopSensor::Configuration
    end
  end

  describe :configure do
    subject do
      configuration.configure do |config|
        config.api_key = api_key
      end
    end
    it do
      expect{ subject }.to change{ configuration.api_key }.from(nil).to api_key
      expect(subject).to be_a ShopSensor::Configuration
    end
  end

  describe :clear! do
    before { configuration.configure { |config| config.api_key = 'some_api_key' } }
    subject { configuration.clear! }
    it { expect{ subject }.to change{ configuration.api_key }.to nil }
  end
end
