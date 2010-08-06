require 'test_helper'

class DashboardControllerTest < ActionController::TestCase

  context "no current user on dashboard index" do
    setup do
      get :index
    end

    should respond_with :redirect
  end

  context "with a current user on dashboard index" do
    setup do
      @user = Factory(:email_confirmed_user)
      sign_in_as @user

      get :index
    end

    should respond_with :success
  end

end
