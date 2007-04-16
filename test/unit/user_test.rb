require File.dirname(__FILE__) + '/../test_helper'

class UserTest < Test::Unit::TestCase
  fixtures :permissions
  fixtures :roles
  fixtures :users

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
  
  
  def test001_create
     user = User.new
     user.name ="test"
     user.username ="test"
     user.set_password("xxx-xxx")
     user.fullname="test account"
     user.admin =false
     user.role = Role.find(:first)
     user.save
     assert_ok user
  end
  

  def test002_valid
     user = User.new
     assert !user.valid?
  end
    
  def test003_duplicate
     user = User.new(:name=>'test2')
     user.set_password "xxx-xxx"
     user.fullname="test account"
     user.admin =false
     assert user.save, 'save first test2 user'
     assert_ok user

     user = User.new(:name=>'test2')
     user.set_password "xxx-xxx"
     user.fullname="test account"
     user.admin =false
     assert !user.save,' should fail save test2 user duplicate '
  end
  
  def test004_create_project
     user = User.find(:first)
     assert_ok user

     project = user.create_project("test-projectss")
     assert_ok project
     user.projects.each{ |p|puts p.name }     
     assert user.projects.detect{|i|i==project}, "project on my list"
     assert user.members.detect{|i|i.project ==project}, "project is on my membership list"
     assert user.role == user.rights(project), "have my default role as a member of the project"
  end
  
  
  def test005_get_permission
     user = User.find(:first)
     role = Role.find(:first)
     user.role = role
     assert_ok user.role
     assert_ok user.rights(user) 
     assert user.rights(user) == user.role

  end
end
