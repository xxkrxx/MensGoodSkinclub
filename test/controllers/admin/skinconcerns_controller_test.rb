require "test_helper"

class Admin::SkinconcernsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_skinconcerns_index_url
    assert_response :success
  end
end
