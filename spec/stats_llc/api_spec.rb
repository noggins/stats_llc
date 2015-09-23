require_relative '../spec_helper'

describe StatsLLC::API do
  let(:api) { described_class.new(
    api_key: ENV["STATS_API_KEY"],
    secret: ENV["STATS_SECRET"]
  ) }

  it 'has a version number' do
    expect(StatsLLC::VERSION).not_to be nil
  end

  describe "#get" do
    it "successfully sends a request to the Stats API and receives a response" do
      path = '/decode/languages'
      response = api.get(path: path)
      sleep(1)
      expect(response.code).to eq 200
    end

    it "successfully sends a request to the Stats API with rest parameters and receives a response" do
      path = '/stats/basketball/nba/teams/:teamId'
      response = api.get(
        path: path,
        rest_params: { teamId: '13' }
      )
      sleep(1)
      json_response = JSON.parse(response, symbolize_names: true)

      expect(response.code).to eq 200

      season = json_response[:apiResults][0][:league][:season]
      team_id = season[:conferences][0][:divisions][0][:teams][0][:teamId]
      expect(team_id).to eq 13
    end

    it "successfully sends a request to the Stats API with query string parameters and receives a response" do
      path = '/stats/basketball/nba/standings/'
      response = api.get(
        path: path,
        query_string_params: { conference: true }
      )
      sleep(1)
      json_response = JSON.parse(response, symbolize_names: true)

      expect(response.code).to eq 200

      season = json_response[:apiResults][0][:league][:season]
      conferences = season[:eventType][0][:conferences]
      expect(conferences.length).to eq 2
    end
  end
end
