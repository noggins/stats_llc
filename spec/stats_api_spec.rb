require_relative './spec_helper'

describe StatsAPI do
  it 'has a version number' do
    expect(StatsAPI::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end

  describe "#request" do
    it 'prints poop' do
      expect { StatsAPI.poop }.not_to raise_error
    end
  end
end
