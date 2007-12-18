require File.dirname(__FILE__) + '/../test_helper'

class ProjectTest < Test::Unit::TestCase
  ## Biorails::Dba.import_model :user_roles
  ## Biorails::Dba.import_model :project_roles
  ## Biorails::Dba.import_model :users
  ## Biorails::Dba.import_model :projects
  ## Biorails::Dba.import_model :memberships
  ## Biorails::Dba.import_model :studies

  def assert_ok(object)
     assert_not_nil object, ' Object is missing'
     assert object.errors.empty? , " #{object.class}.#{object.id} has errors: "+object.errors.full_messages().join(',')
     assert object.valid?,         " #{object.class}.#{object.id} not valid: "+object.errors.full_messages().join(',')
     assert !object.new_record?,   " #{object.class}:#{object} not saved"
  end
  
  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  def test001_valid
     project = Project.new(:name=>'test1',:summary=>'sssss',:status_id=>0)
     assert project.valid? , project.errors.full_messages().join('\n')
  end
  
  def test002_duplicate_name
     project = Project.new(:name=>'test2',:summary=>'sssss',:status_id=>0)
     assert project.save , project.errors.full_messages().join('\n')
     project = Project.new(:name=>'test2',:summary=>'sssss',:status_id=>0)
     assert !project.valid? , "Should not allow duplicate name"
  end


  def test003_invalid
     project = Project.new
     assert !project.valid?  
     project = Project.new(:name=>'test3')
     assert !project.valid?  
     project = Project.new
     assert !project.valid?  
  end

  def test004_save
     project = Project.new(:name=>'test4',:summary=>'sssss')
     assert project.save , project.errors.full_messages().join('\n')
     assert_ok project
     
     assert project.folders.size==1, 'has a root folder'
     assert project.articles.size==0, 'has no articles'
     assert project.users.size==0, 'has one member'
     assert project.memberships.size==0, 'has one membership'
     assert project.owners.size==0, 'has one owner'
  end 
  
  
  def test005_folders
     project = Project.find(1)
     assert project.folders
  end  

  def test006_notes
     project = Project.new(:name=>'test5',:summary=>'sssss')
     assert project.save , project.errors.full_messages().join('\n')
     assert_ok project
     
     folder = project.folder("XXX")
     assert_ok folder
     assert  project.folders.detect{|i|i==folder}     
  end  

  def test007_linked_to
     project = Project.find(1)
     assert project.folders.size>0
     assert !project.folders_for(Study).nil? # array of folders linked to a model type

# test database not populated
#     study = Study.find(:first)
#     assert_ok study
#
#     user = User.find(3)
#     assert_ok user
#
#     folder = project.folder(study)
#     assert_ok folder
#
#     assert project.folders_for(Study).size>0 # array of folders linked to a model type
   end  


  def test0010_create_calendar
    s = Time.now-30.days
    e = Time.now
    project = Project.find(1)
    items = project.tasks.range(s,e)

  end
 
   
end
