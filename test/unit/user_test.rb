require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should have_many :interviews

  context "a valid user" do
    setup do
      @user = Factory(:email_confirmed_user)
    end

    should "have some interviews" do
      @user.interviews << Factory(:interview)
      @user.interviews << Factory(:interview)

      assert_equal 2, @user.interviews.count
    end
  end

end
