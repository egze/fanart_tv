require 'rubygems'
require 'bundler'
require 'fakeweb'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'minitest/unit'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'fanart_tv'

FanartTv.configure do |c|
  c.app_name = "FanartTvGemTestSuite"
  c.app_version = FanartTv::VERSION
  c.contact = "https://github.com/egze/fanart_tv"
  c.perform_caching = true
  c.api_key = "dummy_api_key"
end

FakeWeb.allow_net_connect = false

class MiniTest::Unit::TestCase
end

MiniTest::Unit.autorun
