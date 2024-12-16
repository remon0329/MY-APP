require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: user.id }
      expect(response).to be_successful
      expect(assigns(:user)).to eq(user)
    end
  end
end
