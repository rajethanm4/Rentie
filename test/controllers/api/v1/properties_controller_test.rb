require "test_helper"

class Api::V1::PropertiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_properties_index_url
    assert_response :success
  end
end
