require 'spec_helper'

describe ShopSensor::Configuration do
  after { ShopSensor.configuration.clear! }

  let(:configuration) { ShopSensor.configuration }
  let(:api_key) { 'some_api_key' }

  describe :initialize do
    subject { described_class.new }
    it do
      expect(subject).to be_a ShopSensor::Configuration
      expect(subject.locale).to eq :en_US
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

  describe :site do
    subject { configuration.site }
    context 'when default settings' do
      it { expect(subject).to eq ShopSensor::Configuration::SITES[:en_US] }
    end
    context 'when custom settings' do
      before { ShopSensor.configure { |config| config.locale = :ja_JP } }
      it { expect(subject).to eq ShopSensor::Configuration::SITES[:ja_JP] }
    end
  end

  describe :clone do
    before { ShopSensor.configure { |config| config.api_key = api_key } }
    after { ShopSensor.configuration.clear! }
    let(:api_key) { 'some_api_key' }

    subject { configuration.clone }
    it { expect(subject.to_h).to eq configuration.to_h }

    describe 'deep clone' do
      let(:other_api_key) { 'other_api_key' }
      it do
        expect{ subject.configure{ |config| config.api_key = other_api_key } }.
          not_to change{ configuration.api_key }.from(api_key)
        expect(subject.api_key).to eq other_api_key
      end
    end
  end
end
