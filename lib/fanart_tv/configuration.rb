module FanartTv
  class Configuration
    attr_accessor :app_name, :app_version, :contact,
                  :api_key, :webservice_url_artist,
                  :query_interval, :tries_limit,
                  :cache_path, :perform_caching

    DEFAULT_QUERY_INTERVAL = 1.5
    DEFAULT_TRIES_LIMIT = 5
    DEFAULT_CACHE_PATH = File.join(File.dirname(__FILE__), "..", "tmp", "cache")
    DEFAULT_PERFORM_CACHING = false
    DEFAULT_WEBSERVICE_URL_ARTIST = "http://api.fanart.tv/webservice/artist/%{api_key}/%{musicbrainz_id}/JSON/%{type}/%{sort}/%{limit}/"

    def initialize
      @webservice_url_artist = DEFAULT_WEBSERVICE_URL_ARTIST
      @query_interval = DEFAULT_QUERY_INTERVAL
      @tries_limit = DEFAULT_TRIES_LIMIT
      @cache_path = DEFAULT_CACHE_PATH
      @perform_caching = DEFAULT_PERFORM_CACHING
    end

    def api_key
      raise "api_key must be set" if @api_key.nil?
      @api_key
    end

    def user_agent_string
      %w[ app_name app_version contact ].each do |param|
        raise "#{param} must be set" if instance_variable_get("@#{param}").nil?
      end

      "#{@app_name}/#{@app_version} ( #{@contact} )"
    end
  end

  module Configurable
    def configure
      raise "Configuration missing" unless block_given?
      yield @config ||= FanartTv::Configuration.new
    end

    def config
      @config
    end
  end
  extend Configurable
end