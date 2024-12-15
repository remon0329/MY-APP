require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @user = users(:one) # ユーザーのファクトリを使うか、適切なユーザーを指定
    sign_in @user # Deviseを使っている場合のサインイン
  end

  test "should get show" do
    get profile_path(@user)
    assert_response :success
  end
end
