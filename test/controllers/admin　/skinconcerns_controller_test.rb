require "test_helper"

class Admin　::SkinconcernsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin　_skinconcerns_index_url
    assert_response :success
  end
end
