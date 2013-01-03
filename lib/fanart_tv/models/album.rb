module FanartTv
  class Album
    include BaseModel

    field :mbid_id, String
    field :albumcover, Array
    field :cdart, Array
    
    def albumcover=(value)
      @albumcover = (value || []).map {|ml| FanartTv::Photo.new(ml) }
    end
    
    def cdart=(value)
      @cdart = (value || []).map {|ml| FanartTv::Photo.new(ml) }
    end
    
  end
end