require File.dirname(__FILE__) + '/../test_helper'

class RoleTest < Test::Unit::TestCase
  ## Biorails::Dba.import_model :user_roles
  ## Biorails::Dba.import_model :project_roles
  ## Biorails::Dba.import_model :users
  ## Biorails::Dba.import_model :projects
  ## Biorails::Dba.import_model :memberships
  ## Biorails::Dba.import_model :reports
  ## Biorails::Dba.import_model :report_columns
  
  # Replace this with your real tests.
  def setup
     @model = Report
  end
  
  def test_truth
    assert true
  end
  
  def test_find
     first = @model.find(:first)
     assert first.id
     assert first.name
  end
    
  def test_has_name
    first = @model.find(:first)
    assert first.name    
  end

   def test_valid
    first = @model.find(:first)
    assert first.valid?   
  end

  def test_update
    first = @model.find(:first)
    assert first.save  
  end

  def test_to_s
    first = @model.find(:first)
    assert !first.to_s.nil?  
  end

  def test_to_json
    first = @model.find(:first)
    assert !first.to_json.nil?  
  end

  def test_to_xml
    first = @model.find(:first)
    assert !first.to_xml.nil?  
  end
  
  def test_has_description
    first = @model.find(:first)
    assert first.description    
  end
  

  def test001_create
    report = Report.for_model(Membership)
    report.column("role.name")
    report.column("user.name")
    assert report.save
    data = report.run(:page => 1) 
    assert_not_nil data
  end
  

end
