require 'test_helper'
require 'factory_bot'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include FactoryBot::Syntax::Methods

  def setup
    @user = create(:user) # FactoryBotのcreateメソッドが使える
    sign_in @user
  end

  test "should get show" do
    get profile_path(@user)
    assert_response :success
  end
end
