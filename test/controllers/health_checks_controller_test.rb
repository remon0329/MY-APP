require "test_helper"

class HealthChecksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get health_checks_index_url
    assert_response :success
  end
end
