require_relative '../spec_helper'

describe StatsLLC::API do
  let(:api) { described_class.new(
    api_key: ENV["STATS_API_KEY"],
    secret: ENV["STATS_SECRET"]
  ) }

  it 'has a version number' do
    expect(StatsLLC::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end

  describe "#request" do
    it "successfully sends a request to the Stats API and receives a response" do
      url = '/decode/languages/'
      response = api.request(url)
      expect(response.status).to eq 200
    end
  end
end
