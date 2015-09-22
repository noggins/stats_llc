require 'httparty'
require 'digest'

module StatsLLC
  class API
    include ::HTTParty

    base_uri 'http://api.stats.com/v1'

    def initialize(api_key:, secret:, accept_type: 'json')
      @api_key = api_key
      @secret = secret
      @accept_type = accept_type
    end

    def get(path)
      path_with_params = _build_path_with_params(path)

      self.class.get(path_with_params)
    end

    def _build_path_with_params(path)
      sig = _generate_signature

      api_key_param = "?api_key=#{@api_key}"
      sig_param = "?sig=#{sig}"

      # TODO: clean up the generation of this path (e.g. join a params array)
      path_with_params = "#{path}#{api_key_param}&#{sig_param}"

      path_with_params
    end

    def _generate_signature
      now = Time.now.to_i
      string_to_hash = "#{@api_key}#{@secret}#{now}"
      Digest::SHA256.new.update(string_to_hash).hexdigest
    end
  end

  class Response

  end
end
