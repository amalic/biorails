# == Schema Information
# Schema version: 239
#
# Table name: data_elements
#
#  id                 :integer(11)   not null, primary key
#  name               :string(50)    default(), not null
#  description        :text          
#  data_system_id     :integer(11)   not null
#  data_concept_id    :integer(11)   not null
#  access_control_id  :integer(11)   
#  lock_version       :integer(11)   default(0), not null
#  created_at         :datetime      not null
#  updated_at         :datetime      not null
#  parent_id          :integer(10)   
#  style              :string(10)    default(), not null
#  content            :text          default(), not null
#  estimated_count    :integer(11)   
#  type               :string(255)   
#  updated_by_user_id :integer(11)   default(1), not null
#  created_by_user_id :integer(11)   default(1), not null
#


##
# Copyright © 2006 Robert Shell, Alces Ltd All Rights Reserved
# See license agreement for additional rights
##
#
class DataElement < ActiveRecord::Base
##
# This record has a full audit log created for changes 
#   
  acts_as_audited :change_log
  acts_as_ferret  :fields => {:name =>{:boost=>2,:store=>:yes} , 
                              :description=>{:store=>:yes,:boost=>0},
                              :research_area=>{:boost=>1},
                              :purpose=>{:boost=>0} }, 
                   :default_field => [:name],           
                   :single_index => true, 
                   :store_class_name => true 
#
# Generic rules for a name and description to be present
  validates_uniqueness_of :name, :scope =>"parent_id"
  validates_presence_of :name
  validates_presence_of :description

  belongs_to :system,  :class_name=>'DataSystem',  :foreign_key=>'data_system_id'
  belongs_to :concept, :class_name=>'DataConcept', :foreign_key=>'data_concept_id'
##
# @todo rethink this as a bit of a hack
# These are the holders for the various types of data
# 
  attr_accessor :sql
  attr_accessor :view
  attr_accessor :model
  attr_accessor :list
  attr_accessor :min
  attr_accessor :max
  
  has_many :study_parameters, :dependent => :destroy
  has_many :parameters, :dependent => :destroy
  has_many :task_references, :dependent => :destroy
  
  acts_as_tree :order => "name"  
##
# Test if the element is used
#   
  def not_used
    return (study_parameters.size==0 and parameters.size==0)
  end 
#
# Allowed list of types
# 
  def allowed_styles
    return ['list','model','view','sql']
  end   
##
# convert content to a Array
# 
  def to_array
     return  self.children.collect{|v|v.name}
  end
#
# path to name
#
  def path
     if parent == nil 
        return "/"+name 
     else 
        return parent.path+"/"+name
     end 
  end 

#
# Find all the children of this the concept
#
  def decendents
     [self]+children.inject([]){|decendents,child|decendents+child.decendents}
  end
   
#
# Overide context_columns to remove all the internal system columns.
# 
  def self.content_columns
        @content_columns ||= columns.reject { |c| c.primary || c.name =~ /(lock_version|_by|_at|_id|_count)$/ || c.name == inheritance_column }        
  end
#
#  List values for this element   
#    
  def values
    @values = children.collect unless @values
    return @values
  end    

###
# @todo this will be a killer with value data sets
# 
# Lookup to find value in a list
# 
  def lookup(name)
    item = self.children.detect{|item|item.name.to_s == name.to_s}
    item ||= self.children.detect{|item|item.id.to_s == name.to_s}
    logger.info "lookup for #{self.id}  with #{name} ==> #{item}"
    return item
  end
##
# convert a id to a DataValue
# 
  def reference(id)
    return self.children.detect{|item|item.id.to_s == id.to_s}
  end
  
  def like(name)
    return self.values
  end
  
#
#  List values for this element   
#    
  def choices
     self.values.collect{|row | [ row.name, row.id]} 
  end    

##
# check it there are values for this element
  def values_ok?
    if style != 'child'
      self.values.size>0 
    else
      true
    end 
  rescue
    false
  end 
#
# List of allowed concepts
# 
  def allowed_concepts
      if parent 
         allowed = parent.allowed_concepts
      elsif concept 
         allowed = concept.decendents
      elsif system 
         allowed = system.allowed_concepts
      else  
         allowed = [] 
      end
  end
#
#  List of data systems this element can be linked to
#  
  def allowed_systems
     if system
       allowed = [self.system]
     elsif parent
       allowed = parent.allowed_systems
     else
       allowed = DataSystem.find(:all)
     end
  end
  
#
# Add a child data element linked to this one as the parent
#   
  def add_child(name)
    child = DataElement.new
    child.parent = self
    child.system = self.system
    child.concept= self.concept
    child.style = 'child'
    child.name = name
    child.description = name
    self.children << child
    self.estimated_count =self.children.size
    return child
  end

      
  def DataElement.create_from_params(params={})  
    case params[:style]
      when 'list'
         element = ListElement.create(params)
                
      when 'sql'
         element =SqlElement.create(params)
      when 'model'
         element =ModelElement.create(params)
      when 'view'
         element =ViewModel.create(params)
      else 
       element =DataElement.create(params)
    end   
  end  

    
end

###############################################################################################
# List  based in statement
# 
class ListElement < DataElement
  after_save :populate 

protected
  def populate
     list = eval("[#{content}]") 
     list.each{|item| self.add_child(item)}
  end

end


###############################################################################################
# SQLType based in statement
# 
class SqlElement < DataElement

##
# Get the constents as SQL select statement
  def statement
    return @content
  end

  def to_array
     return self.values.collect{|v|v.name}
  end

##
#  List values for this element   
  def values
   @values = self.system.connection.select_all(content) if !@values
   return @values
  end    
##
# Count the number of records returned with a select count(*) from (select ....)
# 
  def size
    return  self.system.connection.select_all("select count(*) from ("+content+") x")
  end

###
# Lookup to find value in a list
  def lookup(name)
    return  self.system.connection.select_one(content+" where  name='"+name+"'")    
  end

##
# Get by id  
# 
  def reference(id)
    return  self.system.connection.select_one(content+" where  id='"+id+"'")    
  end

  def like(name)
    return data_system.connection.select_one(content+" where  name like'"+name+"%'")    
  end

##
#  List values for this element   
  def choices
     self.values.collect{|v|[v['name'],v['id']]} 
  end    

end

###############################################################################################
# DataElement linked back to defined Model in Rails. This is a simple dynamic link to 
# a model class which used all the standard finder methods etc
# 
class ModelElement < DataElement

  def model
    return eval(self.content)
  end

  def to_array
     return self.values.collect{|v|v.name}
  end

#
#  List values for this element   
#    
  def values
   @values = self.model.find(:all) unless @values
   return @values
  end    

  def size
    return self.model.count
  end
###
# Lookup to find value in a list
# 
  def lookup(name)
    return self.model.find_by_name(name)
  end
##
# Get by id  
# 
  def reference(id)
    return self.model.find(id)
  end

###
# find values like 
#  
  def like(name)
    self.model.find(:all,:limit=>10,:conditions=> ['name like ?',name+"%"] )
  end
#
#  List values for this element   
#    
  def choices
     self.values.collect{|v|[v.name,v.id]} 
  end    

end


###############################################################################################
# This generate a dynamic model class and maps this to the base table or view 
#
class ViewElement < ModelElement

  def model
    model = DataValue.clone()
    model.set_table_name(@content)
    self.system.reset_connection(model)
    return model
  end

end
