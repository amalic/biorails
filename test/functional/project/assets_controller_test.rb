require File.dirname(__FILE__) + '/../../test_helper'
require 'project/assets_controller'

# Re-raise errors caught by the controller.
class Project::AssetsController; def rescue_action(e) raise e end; end

class Project::AssetsControllerTest < Test::Unit::TestCase
  def setup
    @controller = Project::AssetsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @request.session[:current_project_id] = 1
    @request.session[:current_user_id] = 3
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
