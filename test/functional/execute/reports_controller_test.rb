require File.dirname(__FILE__) + '/../../test_helper'
require "#{RAILS_ROOT}/app/controllers/execute/reports_controller"

# Re-raise errors caught by the controller.
class Execute::ReportsController; def rescue_action(e) raise e end; end

class Execute::ReportsControllerTest < Test::Unit::TestCase

  def setup
    @controller = Execute::ReportsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @first = Report.find(2)
    @folder = ProjectFolder.find(:first)
    @request.session[:current_element_id] = @folder.id
    @request.session[:current_project_id] = @folder.project.id
    @request.session[:current_user_id] =3
  end

  def test_setup
    assert_not_nil @controller
    assert_not_nil @request
    assert_not_nil @response
    assert_not_nil @first , "Missing a valid fixture for this controller"
    assert_not_nil @first.id
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'show'
  end

  def test_list
    get :list
    assert_response :success
    assert_template 'show'
    assert_not_nil assigns(:report)
  end

  def test_internal
    get :internal
    assert_response :success
    assert_template 'show'
    assert_not_nil assigns(:report)
  end

  def test_show
    get :show, :id => @first.id
    assert_response :success
    assert_template 'show'
    assert_not_nil assigns(:report)
    assert assigns(:report).valid?
  end

    def test_show_sort_filtered
    get :show, :id => @first.id,:filter=>{},:sort=>{}
    assert_response :success
    assert_template 'show'
    assert_not_nil assigns(:report)
    assert assigns(:report).valid?
  end

  def test_show_ajax
    get :show, :id => @first.id,:format=>'js'
    assert_response :success
    assert_template '_report'
    assert_not_nil assigns(:report)
    assert assigns(:report).valid?
  end

  def test_snapshot        
    get :snapshot , :id => @first.id,:folder_id=>@folder.id,:name=>'xxx-report',:page=>1
    assert_response :redirect
    assert assigns(:project_element)
    assert assigns(:report)
    assert_ok assigns(:project_element)
  end

  def test_snapshot_failed        
    get :snapshot , :id => @first.id,:folder_id=>@folder.id,:name=>"",:title=>"",:page=>1
    assert_response :redirect
    assert assigns(:project_element)
    assert assigns(:report)
    assert !assigns(:project_element).valid?
  end

  def test_visualize
    get :visualize , :id => @first.id
    assert_response :success
    assert_template 'visualize'
  end

  def test_run
    get :run , :id => @first.id
    assert_response :success
    assert_template 'show'
  end

  def test_columns
    get :columns , :id => @first.id
    assert_response :success
  end

  def test_columns_labels
    get :columns , :id => 5,:node=>'project.team'
    assert_response :success
  end

  def test_add_columns
    get :add_column , :id => @first.id,:column=>'xxx~name'
    assert_response :success
  end

  def test_add_columns_ajax
    get :add_column , :id => @first.id,:column=>'xxx~name',:format=>'js'
    assert_response :success
  end

  def test_remove_columns
    @column = @first.columns[0]
    get :remove_column , :id =>  @column.id
    assert_response :success
  end
  
  def test_remove_columns_ajax
    @column = @first.columns[0]
    get :remove_column , :id =>  @column.id,:format=>'js'
    assert_response :success
  end
  
  def test_move_columns
    @column = @first.columns[0]
    get :move_column , :id =>  @column.id, :no=>1
    assert_response :success
  end

  def test_move_columns_ajax
    @column = @first.columns[0]
    get :move_column , :id =>  @column.id, :no=>1,:format=>'js'
    assert_response :success
  end

  def test_update_columns
    @column = @first.columns[0]
    get :update_column , :id =>  @column.id, :field=>'label',:value=>'sssss'
    assert_response :success
    assert_ok assigns(:column)
  end
  
  def test_layout
    get :layout , :id => @first.id
    assert_response :success
  end

  def test_export
    get :export , :id => @first.id
  end

  def test_new
    get :new
    assert_response :success
    assert_template 'new'
    assert_not_nil assigns(:report)
  end

  def test_create_ok
    num = Report.count
    post :create, :report => {:name=>'ssss',:description=>'ssss', :base_model=>'Assay'}
    assert_response :redirect
    assert_equal num+1 , Report.count
  end  
  
  def test_create_failed
    num_request_services = Report.count

    post :create, :report => {}

    assert_response :success
    assert_template 'new'

    assert_equal num_request_services , Report.count
  end

  def test_edit
    get :edit, :id => @first.id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:report)
    assert assigns(:report).valid?
  end

  def test_update
    post :update, :id => @first.id
    assert_response :redirect
    assert_redirected_to :action =>'edit'
  end

  def test_update_jax
    post :update, :id => @first.id,:format=>'js'
    assert_response :success
    assert_template '_edit'
  end

  def test_destroy
    Report.transaction do
        assert_nothing_raised {
          Report.find(@first.id)
        }

        post :destroy, :id => @first.id
        assert_response :redirect
        assert_redirected_to :action =>'list'

        assert_raise(ActiveRecord::RecordNotFound) {
          Report.find(@first.id)
        }
     #raise ActiveRecord::Rollback 
    end  
  end
  
  def test_print
    get :print, :id => @first.id

    assert_response :success
    assert_template 'print'
    assert_not_nil assigns(:report)
    assert assigns(:report).valid?
  end


  
end
