require 'test_helper'

class DocumentsControllerTest < ActionController::TestCase
  setup do
    @user = Factory(:email_confirmed_user)
    @interview = Factory(:interview)
    @document = Factory(:document, :interview => @interview)
    @template = Factory(:template, :user => @user)

    sign_in_as @user
  end

  test "should get index" do
    get :index, :interview_id => @interview.id
    assert_response :success
    assert_not_nil assigns(:documents)
  end

  test "should get new" do
    get :new, :interview_id => @interview.id
    assert_response :success
  end

  test "should create document" do
    assert_difference('Document.count') do
      post :create, :document => @document.attributes, :template_id => @template.id
    end

    assert_redirected_to document_path(assigns(:document))
  end

  test "should show document" do
    get :show, :id => @document.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @document.to_param
    assert_response :success
  end

  test "should update document" do
    put :update, :id => @document.to_param, :document => @document.attributes
    assert_redirected_to document_path(assigns(:document))
  end

  test "should destroy document" do
    assert_difference('Document.count', -1) do
      delete :destroy, :id => @document.to_param
    end

    assert_redirected_to documents_path
  end
end
