require File.dirname(__FILE__) + '/../test_helper'
require 'finder_controller'

# Re-raise errors caught by the controller.
class FinderController; def rescue_action(e) raise e end; end

class FinderControllerTest < Test::Unit::TestCase
  def setup
    @controller = FinderController.new
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
