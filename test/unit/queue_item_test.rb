require File.dirname(__FILE__) + '/../test_helper'

class QueueItemTest < Test::Unit::TestCase
  ## Biorails::Dba.import_model :queue_items

 def setup
    # Retrieve ## Biorails::Dba.import_model via their name
     @model = QueueItem
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

 

end
