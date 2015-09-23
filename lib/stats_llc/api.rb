require 'httparty'
require 'digest'

module StatsLLC
  class API
    include ::HTTParty
    base_uri 'http://api.stats.com/v1'

    def initialize(api_key:, secret:)
      @api_key = api_key
      @secret = secret

      _assign_default_params
    end

    def get(path:, rest_params: {}, query_string_params: {})
      path_with_params = _substitute_rest_params(path, rest_params)

      self.class.get(path_with_params, query: query_string_params)
    end

    def _assign_default_params
      self.class.default_params api_key: @api_key, sig: _generate_signature
    end

    def _generate_signature
      now = Time.now.to_i
      string_to_hash = "#{@api_key}#{@secret}#{now}"
      Digest::SHA256.new.update(string_to_hash).hexdigest
    end

    def _substitute_rest_params(path, rest_params)
      rest_params.each do |key, value|
        param_to_interpolate = ":#{key}"
        path.sub!(param_to_interpolate, value)
      end

      path
    end
  end
end
