require 'test_helper'

class DocumentsControllerTest < ActionController::TestCase
  setup do
    @user = Factory.create(:email_confirmed_user)
    @interview = Factory.create(:interview)
    @document = Factory.create(:document, :interview => @interview)
    @template = Factory.create(:template, :user => @user)

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
    assert_nil @interview.current_document

    get :show, :id => @document.to_param, :make_current => true
    assert_response :success

    assert_equal @document, @interview.reload.current_document
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
