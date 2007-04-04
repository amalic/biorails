# == Schema Information
# Schema version: 233
#
# Table name: request_services
#
#  id            :integer(11)   not null, primary key
#  request_id    :integer(11)   not null
#  service_id    :integer(11)   not null
#  name          :string(128)   default(), not null
#  description   :text          
#  requested_by  :string(60)    
#  requested_for :datetime      
#  assigned_to   :string(60)    
#  accepted_at   :datetime      
#  completed_at  :datetime      
#  lock_version  :integer(11)   default(0), not null
#  created_by    :string(32)    default(), not null
#  created_at    :datetime      not null
#  updated_by    :string(32)    default(), not null
#  updated_at    :datetime      not null
#  status_id     :integer(11)   
#  priority_id   :integer(11)   
#


##
# This is part of a overall request as represents a single service which must be forfilled to 
# complete the overall request
##
# Copyright © 2006 Robert Shell, Alces Ltd All Rights Reserved
# See license agreement for additional rights
# 
class RequestService < ActiveRecord::Base
 include  CurrentStatus
 include  CurrentPriority

##
#Study 
 belongs_to :request

##
#Current Request element is linked to a service provided
#
 belongs_to :queue, :class_name =>'StudyQueue', :foreign_key=>'service_id'

##
# Study Has a number of items associated with the request
# 
  has_many :items, :class_name => "QueueItem" 

  
##
# Submit a request to the queue
# 
  def submit
      logger.debug "submit #{self.name}"
      self.status = CurrentStatus::NEW      
      for item  in request.items
         unless is_submitted(item.value)
           queue_item = self.queue.items.add(item,self)
           queue_item.save
           puts queue_item.to_yaml
         end
      end
      items.size
  rescue Exception => ex
     logger.warn "failed to save cell #{self.to_s}: #{ex.message}"
      
  end 

##
# test if a value is already submitted 
  def is_submitted(value)
    items.any?{|item|item.value == value}
  end

  def priority_id=(new_id)
    self['priority_id']=new_id
    for item in items
      item.priority_id = new_id
    end
  end
   
##
# Submit the request
#  
  def accept
      self.status = CurrentStatus::ACCEPTED
  end 
  
  def reject
      self.status = CurrentStatus::REJECTED
  end

  def complete
      self.status = CurrentStatus::COMPLETED
  end

##
# Change the status of the value and all children
#   
  def status=(value)
    if is_allowed_state(value)
      self.current_state == value
      for item  in self.items
          item.current_state = value
      end
    end
  end
  
  def status   
    if items.any?{|item|item.is_active}
      self.status_id = CurrentStatus::PROCESSING
    elsif items.any?{|item|item.is_finished}
      self.status_id = CurrentStatus::COMPLETED
    else
      self.status_id = CurrentStatus::NEW
    end
    current_state
  end

  def num_active
    return items.inject(0){|sum, item| sum + (item.is_active ? 1 : 0 )}
  end

  def num_finished
    return items.inject(0){|sum, item| sum + (item.is_finished ? 1 : 0 )}
  end
  
  def percent_done
    if items.size>0
      ((100*num_active)/2 + 100*num_finished)/items.size 
    else
      0
    end
  end

  def status_summary   
    "[ #{items.size} / #{num_active} / #{num_finished} ] #{percent_done}%"
  end
 

end
