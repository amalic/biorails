# == Schema Information
# Schema version: 359
#
# Table name: process_steps
#
#  id                  :integer(4)      not null, primary key
#  process_flow_id     :integer(4)      default(0), not null
#  protocol_version_id :integer(4)      default(0), not null
#  name                :string(255)
#  start_offset_hours  :float           default(0.0), not null
#  end_offset_hours    :float           default(1.0), not null
#  expected_hours      :float           default(1.0), not null
#  lock_version        :integer(4)      default(0), not null
#  created_at          :datetime
#  created_by_user_id  :integer(4)      default(1), not null
#  updated_at          :datetime
#  updated_by_user_id  :integer(4)      default(1), not null
#  description         :string(255)
#

# == Description
# This links a single ProcessInstance into a larger ProcessFlow
#
# == Copyright
# 
# Copyright � 2006 Robert Shell, Alces Ltd All Rights Reserved
# See license agreement for additional rights ##
#
#
# This is the rules for use of a single process in the overall process flow.
# Each step when run generates a single task setting the process, and start/expected times
#
class ProcessStep < ActiveRecord::Base
  
  TIME_ENTRY_REGEX = /\d*[\.,]?\d*\s*/
  
  
  attr_accessor :requirements_list

  belongs_to :flow,      :class_name=>'ProtocolVersion',    :foreign_key=>'process_flow_id'
  belongs_to :process,   :class_name=>'ProtocolVersion',:foreign_key=>'protocol_version_id'
  
  has_many :dependents,   
             :class_name=>'ProcessStepLink', 
             :dependent => :destroy, 
             :foreign_key=>'to_process_step_id'
  has_many :requirements, 
             :class_name=>'ProcessStepLink',
             :dependent => :destroy, 
             :foreign_key=>'from_process_step_id'
  
  validates_presence_of :name
  validates_presence_of :process_flow_id 
  validates_presence_of :protocol_version_id 
  validates_presence_of :start_offset_hours
  validates_presence_of :end_offset_hours
  
  
  before_save :resync_end_times
  
  def resync_end_times
    self.expected_hours ||=1
    self.start_offset_hours ||=1
    self.end_offset_hours = self.start_offset_hours + self.expected_hours
  end
  
  #
  # Period in hours the Step is expected to take
  #
  def period
    [(self.expected_hours/self.flow.scaler).floor,1].max
  end  
  #
  # number of hours at start of step
  #
  def starting
    [(self.start_offset_hours/self.flow.scaler).floor,1].max
  end
  #
  # number of hours at end of step
  #
  def ending
     starting+period
  end
  #
  # Remaining hours in the flow
  #
  def remaining
    ((self.flow.expected_days*24/self.flow.scaler) - self.ending).floor
  end
  #
  # Get the process definition 
  #
  def definition
    self.process
  end

  def start_offset
    self.start_offset_hours
  end

  def start_offset=(value)
    self.start_offset_hours = convert_input(value)  
  end  
  
  def expected
    self.expected_hours
  end

  def expected=(value)
    self.expected_hours = convert_input(value)  
  end  
  
  
  #
  # create a process step based 
  #
  def self.copy(item)
    case item
    when Task
      self.copy_task(item)
    when ProcessStep
     self.copy_step(item)
    end
  end

 def to_xml(options = {})
      my_options = options.dup
      my_options[:reference] = {:process=>:name}
      my_options[:except] = [:process_flow_id]
     Alces::XmlSerializer.new(self,my_options ).to_s
 end

 ##
 # Get from xml
 # Lookup the references to catalogue by name was may be in a difference database
 #
 def self.from_xml(xml,options ={} )
      my_options = options.dup
      my_options[:reference] = {:process=>:name}
      Alces::XmlDeserializer.new(self,my_options ).to_object(xml)
 end

protected

  def self.copy_step(other)
    step = ProcessStep.new
    step.process other.process
    step.start_offset_hours = other.start_offset_hours
    step.end_offset_hours = other.end_offset_hours
    step.expected_hours = other.expected_hours
    return step
  end  

  def self.copy_task(task)
    step = ProcessStep.new
    step.process = task.process
    step.start_offset_hours = task.started_at - task.experiment.started_at
    step.end_offset_hours = task.expected_at - task.experiment.started_at
    step.expected_hours = task.expected_hours
    return step
  end 

  def convert_input(value)  
    if TIME_ENTRY_REGEX =~ value
      n = value.to_unit
      if n.to_base.units == "s"
        return n.to_f('hours')
      end
    end
    value.to_f
  end
  
end
