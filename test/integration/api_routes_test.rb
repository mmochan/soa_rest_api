require 'test_helper'

class ApiRoutesTest < ActionDispatch::IntegrationTest
  test "should route to environments" do
      assert_routing '/v1/environments', {controller: "v1/environments", action: "index"}
  end

  #test "should route to an environment" do
  #    assert_routing '/v1/dev', {name: "dev" }, {controller: "v1/environments", action: "show", name: "dev"}
  #end  
  #test "should route to runtime service" do
  #    assert_routing '/v1/dev/runtime', {controller: "v1/mbeans", action: "runtimeservice"}
  #end

#  test "should route to edit service" do
#      assert_routing '/v1/dev/edit', {controller: "v1/mbeans", action: "editservice"}
#  end
end


