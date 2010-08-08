require 'test_helper'

class InterviewsControllerTest < ActionController::TestCase

  context "as a logged in user" do
    setup do
      sign_in_as_valid_user
    end

    context "on the new page" do
      setup do
        get :new
      end

      should respond_with :success
    end

    context "posting a new interview" do
      setup do
        interview = {
          :starts_at => Time.now,
          :candidate_attributes => {
            :name => "Bob",
            :email => "foo@ex.com" }
        }

        post :create, :interview => interview
      end

      should respond_with :redirect
    end
  end

end
