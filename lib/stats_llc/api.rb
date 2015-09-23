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

    def get(path:, rest_params: {}, query_string_params: {})
      path_with_params = _build_path_with_params(path, rest_params, query_string_params)

      self.class.get(path_with_params)
    end

    def _build_path_with_params(path, rest_params, query_string_params)
      sig = _generate_signature
      api_key_param = "?api_key=#{@api_key}"
      sig_param = "&sig=#{sig}"

      # TODO: clean up the generation of this path (e.g. join a params array with &)
      path = "#{path}#{api_key_param}#{sig_param}"

      path = _substitute_rest_params(path, rest_params)
      path = _add_query_string_params(path, query_string_params)


      path
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

    def _add_query_string_params(path, query_string_params)
      query_string_params.each do |param|
        #_add_query_string_param(path, param)
        path += "&#{param[0]}=#{param[1]}"
      end

      path
    end
  end
end
