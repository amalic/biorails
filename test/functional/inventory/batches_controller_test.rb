require File.dirname(__FILE__) + '/../../test_helper'
require "#{RAILS_ROOT}/app/controllers/inventory/batches_controller"

# Re-raise errors caught by the controller.
class Inventory::BatchesController; def rescue_action(e) raise e end; end

class BatchesControllerTest < Test::Unit::TestCase
  # fixtures :batches

  # fixtures :compounds
  # fixtures :users
  # fixtures :projects
  # fixtures :roles
  # fixtures :memberships
  # fixtures :role_permissions

  def setup
    @controller = Inventory::CompoundsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @request.session[:current_project_id] = 1
    @request.session[:current_user_id] = 3
    @item = Batch.find(:first)
  end

  def test_setup
    assert_not_nil @controller
    assert_not_nil @request
    assert_not_nil @response
    assert_not_nil @item
    assert_not_nil @item.id
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list
    assert_response :success
    assert_template 'list'
  end

  def test_show
    get :show, :id => @item.id
    assert_response :success
    assert_template 'show'
  end

  def test_new
    get :new
    assert_response :success
    assert_template 'new'
  end

  def test_create_failed
    num_batches = Batch.count
    post :create, :batch => {}
    assert_response :success
    assert_template 'new'
    assert_equal num_batches, Batch.count
  end

  def test_edit
    get :edit, :id => @item.id
    assert_response :success
    assert_template 'edit'
  end

  def test_update
    post :update, :id => @item.id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    Batch.transaction do
      assert_not_nil Batch.find(@item.id)
      post :destroy, :id => @item.id
      assert_response :redirect
      assert_redirected_to :action => 'list'
      assert_raise(ActiveRecord::RecordNotFound) {
        Batch.find(@item.id)
      }
     # raise ActiveRecord::Rollback 
    end
    
  end
  
end
