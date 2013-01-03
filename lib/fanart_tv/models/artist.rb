module FanartTv
  class Artist
    include BaseModel

    field :mbid_id, String
    field :musiclogo, Array
    field :artistbackground, Array
    field :artistthumb, Array
    field :albums, Array
    field :hdmusiclogo, Array
    field :musicbanner, Array
    
    private
    def musiclogo=(value)
      @musiclogo = (value || []).map {|ml| FanartTv::Photo.new(ml) }
    end
    
    def artistbackground=(value)
      @artistbackground = (value || []).map {|ml| FanartTv::Photo.new(ml) }
    end
    
    def artistthumb=(value)
      @artistthumb = (value || []).map {|ml| FanartTv::Photo.new(ml) }
    end
    
    def albums=(value)
      @albums = []
      (value || {}).each {|k,v| @albums << FanartTv::Album.new(v.merge({mbid_id: k})) }
    end
    
    def hdmusiclogo=(value)
      @hdmusiclogo = (value || []).map {|ml| FanartTv::Photo.new(ml) }
    end
    
    def musicbanner=(value)
      @musicbanner = (value || []).map {|ml| FanartTv::Photo.new(ml) }
    end
    
    class << self
      def find(id, type="all", sort=1, limit=1)
        Client.load(:artist, { musicbrainz_id: id, type: type, sort: sort, limit: limit}, {
          binding: FanartTv::Bindings::Artist,
          create_model: FanartTv::Artist,
          url: FanartTv.config.webservice_url_artist
        })
      end
    end
  end
end