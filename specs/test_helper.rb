%w{
  test/unit
  shoulda
  rack/test
  rr
}.each {|lib| require lib}

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'mongui'

set :environment, :test

class Test::Unit::TestCase
  include Rack::Test::Methods
  include RR::Adapters::TestUnit

  def app
    Sinatra::Application
  end
end
