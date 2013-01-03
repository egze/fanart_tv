module FanartTv
  class Photo
    include BaseModel

    field :id, Integer
    field :url, String
    field :likes, Integer
    field :disc, Integer
    field :size, Integer

  end
end