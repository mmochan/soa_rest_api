require 'test_helper'

class ListingEnvironmentsTest < ActionDispatch::IntegrationTest

  Environment.create( name: "dev", protocol: "t3", adminUrl: 'dev-ofmw-101', user: "weblogic", password: "weblogicd3v", port: 7001)

  setup { host! 'soamgt.com'}

  test "returns a listing of environments" do 
    get '/v1/environments'   
    assert_equal 200, response.status
    refute_empty response.body
  end

  test "show environment details" do 
    get '/v1/dev'   
    assert_equal 200, response.status
    refute_empty response.body
  end

end
