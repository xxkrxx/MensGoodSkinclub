require "test_helper"

class Admin　::SkinconcernControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin　_skinconcern_index_url
    assert_response :success
  end
end
