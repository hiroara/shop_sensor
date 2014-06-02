require 'spec_helper'
require 'json'
require 'hashie'

describe ShopSensor::Client do
  after { ShopSensor.configuration.clear! }

  let(:client) { described_class.new }

  shared_context 'some api_key is configured' do
    before { ShopSensor.configure { |config| config.api_key = api_key } }
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

  shared_context 'mocking API endpoint' do
    before { mock(client).connection.with_no_args.at_least(1) { connection } }
    let(:connection) { Faraday.new(ShopSensor::Client::API_HOST, params: client.send(:default_params)) { |builder| builder.adapter :test, faraday_stubs } }
    let(:faraday_stubs) do
      Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get(File.join("/api/v2", endpoint)) { [200, {}, response_body.to_json] }
      end
    end
    let(:response_body) { { 'some' => 'object' } }
  end

  describe :request do
    subject { client.request endpoint }
    let(:endpoint) { 'brands' }
    it { expect{ subject }.to raise_error ShopSensor::MissingConfiguration }

    context 'when api_key is configured' do
      include_context 'some api_key is configured'
      include_context 'mocking API endpoint'
      it do
        expect{ subject }.not_to raise_error
        expect(JSON.parse(subject.body)['some']).to eq 'object'
      end

      describe :params do
        subject { client.request(endpoint).env.params }
        it do
          expect(subject['site']).to eq client.configuration.site
          expect(subject['pid']).to eq api_key
        end
      end
    end
  end

  describe :get do
    include_context 'some api_key is configured'
    include_context 'mocking API endpoint'
    let(:endpoint) { '/brands' }
    subject { client.get endpoint }
    it { expect(subject).to eq response_body }
  end

  describe :simple_apis do
    include_context 'some api_key is configured'
    include_context 'mocking API endpoint'
    let(:endpoint) { '/colors' }
    subject { client.colors }
    it { expect(subject).to eq response_body }
  end

  describe :product do
    include_context 'some api_key is configured'
    include_context 'mocking API endpoint'
    let(:endpoint) { "/products/#{prod_id}" }
    let(:prod_id) { '359131344' }
    subject { client.product prod_id }
    it { expect(subject).to eq response_body }
  end

  describe :configure do
    subject { client.configuration.configure { |config| config.locale = :fr_FR } }
    it { expect{ subject }.to change{ client.configuration.locale }.from(:en_US).to(:fr_FR) }
  end
end
