##
# Copyright © 2006 Andrew Lemon, Alces Ltd All Rights Reserved
# See license agreement for additional rights
# 

# == Schema Information
# Schema version: 233
#
# Table name: report_columns
#
#  id               :integer(11)   not null, primary key
#  report_id        :integer(11)   not null
#  name             :string(128)   default(), not null
#  description      :text          
#  join_model       :string(255)   
#  label            :string(255)   
#  action           :text          
#  filter_operation :string(255)   
#  filter_text      :string(255)   
#  subject_type     :string(255)   
#  subject_id       :integer(11)   
#  data_element     :integer(11)   
#  is_visible       :boolean(1)    default(true)
#  is_filterible    :boolean(1)    default(true)
#  is_sortable      :boolean(1)    default(true)
#  order_num        :integer(11)   
#  sort_num         :integer(11)   
#  sort_direction   :string(11)    
#  lock_version     :integer(11)   default(0), not null
#  created_by       :string(32)    default(), not null
#  created_at       :datetime      not null
#  updated_by       :string(32)    default(), not null
#  updated_at       :datetime      not null
#  join_name        :string(255)   
#
class ReportColumn < ActiveRecord::Base

  belongs_to :report
  belongs_to :filter, :polymorphic => true
##
# This record has a full audit log created for changes 
#   
  acts_as_audited :change_log

##
# Simgle helper call to customize a columns property
#
#
  def customize(params={})
    logger.debug "old ReportColumn.customize #{id} #{label} #{is_visible} #{order_num} #{is_sortable} #{sort_num} #{sort_direction} #{filter}"
    if params.size>0
      self.is_visible = params[:is_visible]=='1'
      self.label = params[:label]                    if params[:label]
      self.order_num = params[:order_num]            if params[:order_num]
  
      self.is_filterible =  params[:is_filterible]=='1'
      self.filter =  params[:filter]                 if  params[:filter] 
      self.filter =  params[:action]                 if  params[:action] 
      
      self.is_sortable =  params[:is_sortable]=='1'
      self.sort_num = params[:sort_num]              if params[:sort_num]
      self.sort_direction = params[:sort_direction]  unless params[:sort_direction].nil?
    end
    logger.debug "new ReportColumn.customize #{id} #{label} #{is_visible} #{order_num} #{is_sortable} #{sort_num} #{sort_direction} #{filter}"
  end
  
##
# Get the name as a table attribute pair 
# 
# @todo Need to work on how to handle same table appearing multiple times.
# 
  def table_attribute
    attribute = self.name.split(".").pop
    if  join_model
    return join_model.tableize.to_s + "." + attribute.to_s
    else
    return report.model.table_name.to_s + "." + attribute.to_s
    end
  end

  def has_many?
   self.join_name=="has_many"
  end
##
# Set the next direction for a sort based on current
#    
  def next_direction
     case self.sort_direction
     when 'asc' then 'desc'
     when 'desc' then 'asc'
     else 'asc'
     end
  end
  
  def format(value)
     if value.nil?
         '<null>'  
     elsif value.kind_of? Numeric
         sprintf("%01.2f", value).to_s
     else 
         value.to_s 
     end
  end

##
# The the value for display for the row/column. As this may be on another object
# follow the the dot separated path in the name (eg object.object.method) to the end.
# In the case of has_many relation a array of values is returned
# 
  def value(row)
    elements = name.split(".").reverse
    @value = values(row,elements)
  rescue Exception => ex
      logger.error ex.message
      logger.error ex.backtrace.join("\n")  
      return " "  
  end


##
# Get the number of items in cell for details
# 
  def size(row)
    elements = name.split(".").reverse
    @value = values(row,elements)
    if @value.class == Array
      @value.size
    else
      1
    end
  end  
##
# go down the tree of related objects to find the list of matchingb values. In case of 
# a has_Reportmany relationship this may lead down a whole tree. This can result in a large
# nested tree of of values where links are arrays. 
# eg. row.experiments.tasks.name -> [[a,b,c],[e,f,g]]
# 
#   
  def values(object,elements) 
    out = []
    while elements.size>0 and !object.nil? do
      object = object.send(elements.pop)        
      if object.class == Array
        for item in object
           out << values(item, elements.clone)
        end 
        return out
      end 
     end  
     return object
  rescue Exception => ex
      logger.error ex.message
      logger.error ex.backtrace.join("\n")    
  end
  

##
# Set the filter to apply to the current column
# This scans for a starting operator =, > or < then scans
# the string for a '%' or '?' in string to set a like operator
#
  def filter= (value)
    puts "filter= #{value}"
    case value 
    when /^=/
       self.filter_operation = "="
       self.filter_text = value[1..10000] 
    when /^>/
       self.filter_operation = ">"
       self.filter_text = value[1..10000] 
    when /^</
       self.filter_operation = "<"
       self.filter_text = value[1..10000] 
    when /%/
       self.filter_operation = "like"
       self.filter_text = value
    when /^in/ 
       self.filter_operation = "in"
       self.filter_text = value
    when "" 
       self.filter_operation = nil
       self.filter_text = nil
    when nil 
       self.filter_operation = nil
       self.filter_text = nil
    else 
       self.filter_operation = "="
       self.filter_text = value
    end   
  end

##
# Get the filter to apply to the current column
#   
  def filter
    case self.filter_operation
    when nil
      nil
    when "in
      "#{self.filter_text}"
    when '=','like'
      self.filter_text
    else
      "#{self.filter_operation}#{self.filter_text}"
    end
  end

end
