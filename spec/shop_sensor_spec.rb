require 'spec_helper'

describe ShopSensor do
  it { expect(ShopSensor::VERSION).to eq "0.0.1" }

  describe :configure do
    subject { ShopSensor.configure &block }
    let(:block) { proc { |config| @config = config } }
    it { expect{ subject }.to change{ @config }.from nil }
  end

  describe :configuration do
    subject { ShopSensor.configuration }
    it { expect(subject).to be_a ShopSensor::Configuration }
  end
end
