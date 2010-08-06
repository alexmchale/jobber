require 'test_helper'

class InterviewsControllerTest < ActionController::TestCase

  context "as a logged in user" do
    setup do
      @user = Factory(:email_confirmed_user)
      sign_in_as @user
    end

    context "on the new page" do
      setup do
        get :new
      end

      should respond_with :success
    end

    context "posting a new interview" do
      setup do
        post :create, :interview => { :starts_at => Time.now, :candidate_attributes => { :name => "Bob", :email => "foo@ex.com" } }
      end

      should respond_with :redirect
    end
  end

end
