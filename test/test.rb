ENV["RACK_ENV"] = "test"

require 'minitest/autorun'
require 'minitest/reporters'
require 'rack/test'

require_relative '../main'

Minitest::Reporters.use!

class MainTest < Minitest::Test
  include Rack::Test::Methods 

  def app 
    Sinatra::Application
  end

  def test_homepage_with_no_data
    get '/'

    assert_equal 200, last_response.status
    assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
    assert_includes last_response.body, "This week's meals"
  end



end