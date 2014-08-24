require 'test_helper'

class MbeanTest < ActionDispatch::IntegrationTest

  setup { host! 'iss-mgmt-1' }

  test 'access the DomainConfiguration beans for JDBC' do
    get '/v1/tst-ofmw-501/config/jdbc'
    assert_equal 200, response.status
    refute_empty response.body
  end

  test 'access the domain configuration' do
    get '/v1/tst-ofmw-501/domain'
    assert_equal 200, response.status
    refute_empty response.body
  end  

  test 'access the runtime configuration' do
    get '/v1/tst-ofmw-501/runtime'
    assert_equal 200, response.status
    refute_empty response.body
  end

  test 'access the edit configuration' do
    get '/v1/tst-ofmw-501/edit'
    assert_equal 200, response.status
    refute_empty response.body
  end

end
