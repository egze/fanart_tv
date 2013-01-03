# encoding: UTF-8
module FanartTv
  module Bindings
    module Artist
      def parse(json)
        json[json.keys[0]]
      end

      extend self
    end
  end
end