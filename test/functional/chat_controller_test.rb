require 'test_helper'

class ChatControllerTest < ActionController::TestCase

  context "a logged in user on the chat page" do

    setup do
      @user = Factory.create(:email_confirmed_user)
      sign_in_as @user

      @interview = Factory.create(:interview)
      @interview.users << @user

      get :show, :id => @interview.id
    end

    should respond_with :success

    should "post new messages" do
      assert_equal 0, @interview.chat_messages.count

      post :create, :id => @interview.id, :message => "hi"

      assert_equal 1, @interview.chat_messages.count
      assert_equal "hi", @interview.chat_messages.last.message
      assert_equal @user, @interview.chat_messages.last.user
    end

  end

end
