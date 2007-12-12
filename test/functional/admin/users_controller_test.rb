require File.dirname(__FILE__) + '/../../test_helper'
require "#{RAILS_ROOT}/app/controllers/admin/users_controller"

# Re-raise errors caught by the controller.
class Admin::UsersController; def rescue_action(e) raise e end; end

class Admin::UsersControllerTest < Test::Unit::TestCase
  # # fixtures :projects
  # # fixtures :project_elements
  # # fixtures :users
  # # fixtures :roles
  # # fixtures :role_permissions
  # # fixtures :permissions
  # # fixtures :projects

  def setup
    @controller = Admin::UsersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @request.session[:current_project_id] = 1
    @request.session[:current_user_id] = 3
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end

  def test001_setup
    assert_not_nil @controller
    assert_not_nil @response
    assert_not_nil @request
  end
  
  def test002_index
    @session[:current_user_id] = User.find(:first)
    @session[:current_project_id] = Project.find(:first)
    get :index,nil,@session
    assert_response :success
  end
  
  def test003_new
    get :new,nil,@session
    assert_response :success
  end

  def test004_create
    @params = {:user => {:name =>'test3',:password =>'test3', :login =>'test3', :role_id => 1}}
    post :create, @params, @session
    assert_response :success
  end
  
  def test005_edit
    get :edit
    assert_response :success
  end

  def test006_update
    @params = {:user => {:name =>'test3',:password =>'test3', :login =>'test3', :role_id => 1}}
    post :update,  @params, @session
    assert_response :success
  end  
  
end
