module FanartTv
  module Client
    def http
      @faraday ||= Faraday.new do |f|
        f.request :json
        #f.use :instrumentation
        f.adapter Faraday.default_adapter # make requests with Net::HTTP
        f.response :json
        #f.use     FanartTv::Middleware # run requests with correct headers
      end
    end

    def load(resource, query, params)
      raise Exception.new("You need to run FanartTv.configure before querying") if FanartTv.config.nil?

      response = contents_of(build_url(params[:url], query))
      data = params[:binding].parse(response.body)

      if params[:create_model]
        params[:create_model].new(data)
      elsif params[:create_models]
        models = data.map{ |item| params[:create_models].new(item) }
        models.sort!{ |a, b| a.send(params[:sort]) <=> b.send(params[:sort]) } if params[:sort]
        models
      else
        data
      end
    rescue Faraday::Error::ParsingError
      nil
    end

    def contents_of(url)
      if method_defined? :get_contents
        get_contents url
      else
        http.get url
      end
    end

    def build_url(url, params)
      url % params.merge({api_key: FanartTv.config.api_key})
    end

    include ClientModules::TransparentProxy
    #include ClientModules::FailsafeProxy
    #include ClientModules::CachingProxy
    extend self
  end
end