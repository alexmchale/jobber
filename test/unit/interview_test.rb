require 'test_helper'

class InterviewTest < ActiveSupport::TestCase

  should have_one :candidate
  should have_many :users
  should have_one :current_document
  should have_many :documents

  should validate_presence_of :starts_at

  context "an interview" do
    setup do
      @interview = Factory(:interview, :access_code => "X")
      @user1 = Factory(:email_confirmed_user)
      @user2 = Factory(:email_confirmed_user)

      @user1.interviews << @interview
    end

    should "grant access correctly by user" do
      assert_equal true, @interview.authorized?(@user1)
      assert_equal false, @interview.authorized?(@user2)
    end

    should "grant access correctly by access code" do
      assert_equal true, @interview.authorized?("X")
      assert_equal false, @interview.authorized?("Y")
      assert_equal false, @interview.authorized?(nil)
    end
  end

end
