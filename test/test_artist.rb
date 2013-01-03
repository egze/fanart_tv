require 'helper'

class TestArtist < MiniTest::Unit::TestCase
  
  def test_find_artist
    FakeWeb.register_uri(:any, %r|http://api.fanart.tv/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/artist.json"))
    
    mbid_id = "f4a31f0a-51dd-4fa7-986d-3095c40c5ed9"
    artist = FanartTv::Artist.find(mbid_id)
    assert_equal mbid_id, artist.mbid_id
    assert_equal 5474, artist.musiclogo.first.id
    assert_equal "http://fanart.tv/fanart/music/f4a31f0a-51dd-4fa7-986d-3095c40c5ed9/artistbackground/6/evanescence-4dc7198199ccd.jpg", artist.artistbackground.first.url
    assert_equal 1, artist.artistthumb.first.likes
    assert_equal "2187d248-1a3b-35d0-a4ec-bead586ff547", artist.albums.first.mbid_id
    assert_equal 43, artist.albums.first.albumcover.first.id
  end
  
  def test_find_artist_should_return_nil_if_nothing_found
    FakeWeb.register_uri(:any, %r|http://api.fanart.tv/|, :body => "null")
    
    mbid_id = "f4a31f0a-51dd-4fa7-986d-3095c40c5ed9"
    artist = FanartTv::Artist.find(mbid_id)
    assert_nil artist
  end
  
end
