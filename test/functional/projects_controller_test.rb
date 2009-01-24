require File.dirname(__FILE__) + '/../test_helper'
require  "projects_controller"

# Re-raise errors caught by the controller.
class ProjectsController; def rescue_action(e) raise e end; end

class ProjectsControllerTest < Test::Unit::TestCase

  def setup
    @controller = ProjectsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @request.session[:current_project_id] = 1
    Project.current = Project.find(1)
    User.current = User.find(3)
    @request.session[:current_user_id] = 3
    @item = Project.find(:first)
  end

  def fill_session_user
    user = User.find(:first)
    @request.session[:user_id] = user.id
  end

  def fill_session_project
    project = Project.find(:first)
    @request.session[:project_id] = project.id
  end

  def test_setup
    fill_session_project
    fill_session_user
    assert_not_nil @controller
    assert_not_nil @response
    assert_not_nil @request
    assert_not_nil @request.session[:user_id]
    assert_not_nil @request.session[:project_id]
  end

  def test_list
    fill_session_user
    get :list
    assert_response :success
  end

  def test_index
    fill_session_user
    get :index
    assert_response :success
  end

  def test_get_index_as_xml
    fill_session_user
    get :index,{:format=>'xml'}
    assert_response :success
  end

  def test_get_index_as_csv
    fill_session_user
    get :index,{:format=>'csv'}
    assert_response :success
  end

  def test_new_root
    get :new_root
    assert_response :success
    assert !assigns(:parent)
    assert assigns(:project_list)
    assert assigns(:project)
  end

  def test_new_current_parent
    get :new
    assert_response :success
    assert assigns(:parent)
    assert assigns(:project_list)
    assert assigns(:project)
  end

  def test_new_with_type
    get :new,:project_type=>1
    assert_response :success
    assert assigns(:parent)
    assert assigns(:project_list)
    assert assigns(:project)
  end

  def test_new_child
      get :new,:id=>@item.id
      assert_response :success
      assert assigns(:parent)
      assert assigns(:project_list)
      assert assigns(:project)
  end

  def test_new_child_with_type
      get :new, :id=>@item.id, :project_type=>1
      assert_response :success
      assert assigns(:parent)
      assert assigns(:project_list)
      assert assigns(:project)
  end

  def test_create
     post :create,  {"project"=>{"team_id"=>"2", "name"=>"this is anothert new project", "project_type_id"=>"1",'title'=>'dggsdgsd', "description"=>"test"}}
     assert_response :redirect
     assert_equal 'Project was successfully created.', flash[:notice]
     assert_redirected_to :action => 'show'
   end

  def test_create_child
     post :create,  {"project"=>{"team_id"=>@item.team_id,"parent_id"=>@item.id, "name"=>"this is anothert new project", "project_type_id"=>"1",'title'=>'dggsdgsd', "description"=>"test"}}
     assert_response :redirect
     assert_equal 'Project was successfully created.', flash[:notice]
     assert_redirected_to :action => 'show'
   end

  def test_destroy
    project = Project.create("team_id"=>"2", "name"=>"this is anothert new project", "project_type_id"=>"1",'title'=>'dggsdgsd', "description"=>"test")
    post :destroy ,:id=>project.id
    assert_response :redirect
    assert_redirected_to :action => 'index'
  end

  def test_create_invalid
    destory_id_generator(Project)
    post :create,  {"project"=>{"team_id"=>"2","project_type_id"=>"1",'title'=>'dggsdgsd', "description"=>"test"}}
    assert :success #reloads the existing page
    assert_not_nil assigns(:project)
    assert !assigns(:project).valid?
    assert assigns(:project).errors
    assert assigns(:project).errors[:name]
  end

  def test_create_invalid_child
    destory_id_generator(Project)
    post :create,  {"project"=>{"team_id"=>@item.team_id,"parent_id"=>@item.id,'title'=>'dggsdgsd',"project_type_id"=>"1", "description"=>"test"}}
    assert :success #reloads the existing page
    assert_not_nil assigns(:project)
    assert !assigns(:project).valid?
    assert assigns(:project).errors
    assert assigns(:project).errors[:name]
  end

  def test_update_should_change_item_when_valid
    post :update, "project"=>{"team_id"=>"2", "name"=>"any", "project_type_id"=>"1", "description"=>"Project to uncover the secret formula in Coca-Cola."}
    assert_redirected_to :action=>'show'
  end

  def test_update_without_name_should_not_be_valid
    post :update, "project"=>{"team_id"=>"2", "name"=>"", "project_type_id"=>"1", "description"=>"Project to uncover the secret formula in Coca-Cola."}
    assert :success
    assert_not_nil assigns(:project)
    assert !assigns(:project).valid?
    assert assigns(:project).errors
    assert assigns(:project).errors[:name]
    assert_empty_error_field('project[name]')
    assert_tag :tag=>'li', :content=>"Name can't be blank"
  end

  def test_update_without_description_should_not_be_valid
    post :update, "project"=>{"team_id"=>"2", "name"=>"any", "project_type_id"=>"1", "description"=>""}
    assert :success
    assert_not_nil assigns(:project)
    assert !assigns(:project).valid?
    assert assigns(:project).errors
    assert assigns(:project).errors[:description]
    assert_empty_error_field('project[description]')
    assert_tag :tag=>'li', :content=>"Description can't be blank"
  end

  def test_get_show
    get :show ,:id=>@item.id
    assert_response :success
  end

  def test_get_show_as_xml
    get :show ,:id=>@item.id,:format=>'xml'
    assert_response :success
  end

  def test_get_new
    get :new
    assert_response :success
    assert_template 'new'
    assert_tag :tag=>'input', :attributes=>{:name=>'project[name]'}
  end

  def test_link
    post :link, :object_class=>"Task",:object_id=>1
    assert_response :redirect
  end

  def test_unlink
    element = @item.folder.add_link(Task.find(1))
    post :unlink,:project_element_id => element.id
    assert_response :redirect
  end


  def test_post_create_fail
    post :create,:project=>{}
    assert_response :success
    assert_template 'new_root'
  end

  def test_get_edit
    get :edit
    assert_response :success
    assert_template 'edit'
    assert_tag :tag=>'input', :attributes=>{:name=>'project[name]'}
  end

  def assert_xml(contents)
    @xdoc = Document.new(contents.to_s)
  end

  def assert_xpath(path, message = '')
    assert_not_nil XPath.first(@xdoc, path),
      message +
      "\nseeking: #{path.inspect} in\n#{@xdoc.to_s}"
  end
end
