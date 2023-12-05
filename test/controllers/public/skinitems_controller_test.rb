require "test_helper"

class Public::SkinitemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_skinitems_index_url
    assert_response :success
  end

  test "should get show" do
    get public_skinitems_show_url
    assert_response :success
  end
end
