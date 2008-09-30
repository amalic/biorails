# == Schema Information
# Schema version: 359
#
# Table name: task_results
#
#  id                   :integer(4)      default(0), not null, primary key
#  protocol_version_id  :integer(4)      default(0), not null
#  parameter_context_id :integer(4)      default(0), not null
#  label                :string(255)
#  row_label            :string(255)
#  row_no               :integer(4)      default(0), not null
#  column_no            :integer(4)
#  task_id              :integer(4)      default(0), not null
#  parameter_id         :integer(4)      default(0), not null
#  parameter_name       :string(62)      default(""), not null
#  data_value           :binary(21474836
#  created_by_user_id   :integer(4)      default(0), not null
#  created_at           :datetime        not null
#  updated_by_user_id   :integer(4)      default(0), not null
#  updated_at           :datetime        not null
#

# == Description
# This is a simple read only view based model for reporting on numeric data in the database.
# It basically joins the text_values to a subject object reference in the same row for reporting
# For good performance the data_type,reference_parameter_id should be set in the driving query
# eg conditons => ['data_type=? and reference_parameter_id=?,'Compound',12] 
#  
#  Note: performance of this query with large data sets may be poor as there a number of union
#  all operations and conversions to bring separater data sources together.
#  
# == Copyright
# 
# Copyright � 2006 Robert Shell, Alces Ltd All Rights Reserved
# See license agreement for additional rights ##
#
class TaskResult < ActiveRecord::Base

 def initialize(*args)
   super(*args)
   @readonly = true
 end

##
# The task this context belongs too
 belongs_to :task
##
# Direct link back to protocol version
# 
 belongs_to :process, :class_name=>'ProtocolVersion',:foreign_key=>'protocol_version_id'
##
# Direct link to parameter context
#
 belongs_to :definition, :class_name=>'ParameterContext',:foreign_key=>'parameter_context_id' 
##
# context is provides a logical grouping of TaskItems which need to be seen as a whole to get the true
# meaning of the data (eg. Inhib+Dose+Sample is useful result!)
 belongs_to :context, :class_name=>'TaskContext',:foreign_key=>'task_context_id'
##
# The parameter definition the Item is linked back to from the Process Instance
# Added IC50(Output) etc to the basic value and defines the validation rules like must be numeric!
#  
 belongs_to :parameter
 
 def name
   return self.parameter_name
 end
 
 ##
 # Get the value for this result
 # 
 def value
   return self.data_value 
 end

 
 end
