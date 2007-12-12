require File.dirname(__FILE__) + '/../test_helper'

class TaskTest < Test::Unit::TestCase

 def setup
     @model = Task
  end
 
  def test_find
     first = @model.find(:first)
     assert first.id
     assert first.name
  end
  
  def test_new
    first = @model.new
    assert first
    assert first.new_record?
    assert !first.valid?
  end

  def test_update
    first = @model.find(:first)
    assert first.save
    assert !first.new_record?
    assert first.valid?
  end
  
  def test_has_name
    first = @model.find(:first)
    assert first.name    
  end

  def test_has_description
    first = @model.find(:first)
    assert first.description    
  end

  def test_has_experiment
    first = @model.find(:first)
    assert first.experiment
  end
 
  def test_has_process
    first = @model.find(:first)
    assert first.process
  end

  def test_has_project
    first = @model.find(:first)
    assert first.project 
  end

  def test_has_period
    first = @model.find(:first)
    assert first.period 
  end  
  
  def test_has_started_at
    first = @model.find(:first)
    assert first.started_at     
  end

  def test_has_expected_at
    first = @model.find(:first)
    assert first.expected_at     
  end

  def test_has_has_contexts
    first = @model.find(:first)
    assert first.contexts     
  end  
  
  def test_has_has_items
    first = @model.find(:first)
    assert first.items     
  end  
  
  def test_has_process_name
    first = @model.find(:first)
    assert first.process_name     
  end  

  def test_has_protocol_name
    first = @model.find(:first)
    assert first.protocol_name     
  end  
  
  def test_has_experiment_name
    first = @model.find(:first)
    assert first.experiment_name     
  end  

  def test_to_titles
    first = @model.find(:first)
    assert first.to_titles.size >0  
  end  

  def test_to_matrix
    first = @model.find(:first)
    assert first.to_matrix  
  end  

  def test_to_html
    first = @model.find(:first)
    assert first.to_html
  end  
  
  def test_has_valid_date_range
    first = @model.find(:first)
    assert first.started_at < first.expected_at     
  end
  
  # Replace this with your real tests.
  def test000_truth
    assert true
  end

  def test001_status
    task = Task.new(:name=>'test')
    assert task
    task.status_id = nil
  end
  
  def test002_status
    task = Task.new(:name=>'test')
    task.status = Alces::ScheduledItem::NEW
    assert task.status_id==Alces::ScheduledItem::NEW 
    assert task.is_allowed_state(Alces::ScheduledItem::ACCEPTED)
    assert task.is_allowed_state(Alces::ScheduledItem::REJECTED)
  end
  
  def test003_status
    task = Task.new(:name=>'test')
    task.status = Alces::ScheduledItem::REJECTED
    assert task.status_id==Alces::ScheduledItem::REJECTED
    assert task.is_allowed_state(Alces::ScheduledItem::NEW)
    assert task.has_failed
  end
  
  def test004_status
    task = Task.new(:name=>'test')
    task.status = Alces::ScheduledItem::ACCEPTED
    assert task.status_id==Alces::ScheduledItem::ACCEPTED
    assert task.is_status(Alces::ScheduledItem::ACCEPTED)
    assert task.is_status('accepted')
    assert task.is_status([1,2,3])
    assert task.allowed_status_list.size>1
    assert task.is_allowed_state(Alces::ScheduledItem::COMPLETED)
    assert task.is_allowed_state(Alces::ScheduledItem::WAITING)
    assert task.is_allowed_state(Alces::ScheduledItem::PROCESSING)
    assert task.is_allowed_state(Alces::ScheduledItem::ABORTED)
    assert task.is_allowed_state(Alces::ScheduledItem::REJECTED)  

  end
  
  def test005_status
    task = Task.new(:name=>'test')
    task.status = 'waiting'
    assert task.status_id==Alces::ScheduledItem::WAITING
    assert task.is_allowed_state(Alces::ScheduledItem::COMPLETED)
    assert task.is_allowed_state(Alces::ScheduledItem::PROCESSING)
    assert task.is_allowed_state(Alces::ScheduledItem::ABORTED)
    assert !task.is_allowed_state(Alces::ScheduledItem::REJECTED)  # can only abort now 

  end
  
  def test006_status
    task = Task.new(:name=>'test')
    task.status = Alces::ScheduledItem::PROCESSING
    assert task.status_id==Alces::ScheduledItem::PROCESSING
    assert task.is_status('processing')
    assert task.is_active

  end
  
  def test007_status
    task = Task.new(:name=>'test')
    task.status = Alces::ScheduledItem::PROCESSING
    assert task.is_allowed_state(Alces::ScheduledItem::COMPLETED)
    assert task.is_allowed_state(Alces::ScheduledItem::WAITING)
    assert task.is_allowed_state(Alces::ScheduledItem::PROCESSING)
    assert task.is_allowed_state(Alces::ScheduledItem::ABORTED)
    assert task.is_allowed_state(Alces::ScheduledItem::VALIDATION)
    assert !task.is_allowed_state(Alces::ScheduledItem::REJECTED)  # can only abort now    

  end
  
  def test008_status
    task = Task.new(:name=>'test')
    task.status = Alces::ScheduledItem::PROCESSING
    task.status = Alces::ScheduledItem::ACCEPTED
    assert task.status_id==Alces::ScheduledItem::ACCEPTED
  end
  
  def test009_status
    task = Task.new(:name=>'test')
    task.status = Alces::ScheduledItem::VALIDATION
    assert task.status_id==Alces::ScheduledItem::VALIDATION
    assert task.is_allowed_state(Alces::ScheduledItem::COMPLETED)
    assert task.is_allowed_state(Alces::ScheduledItem::WAITING)
    assert task.is_allowed_state(Alces::ScheduledItem::PROCESSING)
    assert !task.is_allowed_state(Alces::ScheduledItem::REJECTED)
    assert task.is_allowed_state(Alces::ScheduledItem::ABORTED)
  end
  
  def test010_status
    task = Task.new(:name=>'test')
    task.status = Alces::ScheduledItem::COMPLETED
    
    assert task.status_id==Alces::ScheduledItem::COMPLETED
    assert task.is_status(Alces::ScheduledItem::COMPLETED)
    assert task.is_status('completed')
    assert task.is_status([1,2,3,4,5])
  end
  
end
