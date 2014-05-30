require 'spec_helper'

describe ShopSensor::Client do
  let(:client) { described_class.new }

  shared_context 'some api_key is configured' do
    before { ShopSensor.configure { |config| config.api_key = api_key } }
    after { ShopSensor.configuration.clear! }
    let(:api_key) { 'some_api_key' }
  end

  describe :initialize do
    subject { client }
    it do
      expect(subject).to be_a ShopSensor::Client
      expect(subject.configuration).to be_a ShopSensor::Configuration
      expect(subject.configuration.api_key).to be_nil
    end

    context 'when api_key is configured' do
      include_context 'some api_key is configured'
      it { expect(subject.configuration.api_key).to eq api_key }
    end
  end

  describe :request do
    subject { client.request endpoint }
    let(:endpoint) { '/brands' }
    it { expect{ subject }.to raise_error ShopSensor::MissingConfiguration }

    context 'when api_key is configured' do
      include_context 'some api_key is configured'
      it do
        expect{ subject }.not_to raise_error
      end
      pending
    end
  end
end
