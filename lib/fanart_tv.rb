require 'json'
require 'faraday'
require 'faraday_middleware'

require "fanart_tv/version"
require "fanart_tv/configuration"

require "fanart_tv/client_modules/transparent_proxy"
require "fanart_tv/client"

require "fanart_tv/models/base_model"
require "fanart_tv/models/artist"
require "fanart_tv/models/photo"
require "fanart_tv/models/album"

require "fanart_tv/bindings/artist"