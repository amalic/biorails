# == Schema Information
# Schema version: 239
#
# Table name: data_concepts
#
#  id                 :integer(11)   not null, primary key
#  parent_id          :integer(11)   
#  name               :string(50)    default(), not null
#  data_context_id    :integer(11)   default(0), not null
#  description        :text          
#  access_control_id  :integer(11)   
#  lock_version       :integer(11)   default(0), not null
#  created_at         :datetime      not null
#  updated_at         :datetime      not null
#  type               :string(255)   default(DataConcept), not null
#  updated_by_user_id :integer(11)   default(1), not null
#  created_by_user_id :integer(11)   default(1), not null
#

##
# Copyright © 2006 Robert Shell, Alces Ltd All Rights Reserved
# See license agreement for additional rights
##

###
#  Catalogue management in the system is divided into two part a tree of concepts which
#  represents the logical namespace structure. This is held in this DataConcept model. 
#  This is linked to a number of physical implemenations in DataElement model. 
#
#   In the system the root DataConcept's are managed to a special subclass called a 
#   DataContext. 
#
class DataConcept < ActiveRecord::Base
##
# This record has a full audit log created for changes 
#   
  acts_as_audited :change_log

##
# Generic rules for a name and description to be present
#
  validates_uniqueness_of :name, :scope =>"parent_id"
  validates_presence_of :name
  validates_presence_of :description
##
# This concept belongs to this route DataContext which defines the overall namespace.
# By default concepts are in the BioRails context
#  
  belongs_to :context, :class_name => 'DataContext', :foreign_key=>'data_context_id'
##
# This logical concept is implemented via a number of DataElement  which link to a external 
# DataSystem to retreive a list of DataValues to use a  lookup
#  
  has_many :elements,  :class_name => 'DataElement',:conditions => "parent_id is null",  :dependent => :destroy
##
# The concept is used in the system in a number o parameter_types.
# these define one of a key data dimensions for values
#
  has_many :parameter_types,  :dependent => :destroy
##
# The concepte appears in a treee
#  
  acts_as_tree :order => "name"  
##
# See if the parameter is used
# 
  def not_used
    return (parameter_types.size==0 and elements.size==0)
  end  
##
# unique path name for the concept 
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
  
  def to_xml(options = {})
      my_options = options.dup
      my_options[:include] = [:children,:elements,:parameter_types]
      Alces::XmlSerializer.new(self, my_options  ).to_s
 end

##
# Get DataConcept from xml
# 
 def self.from_xml(xml,options = {})
      my_options = options.dup
      my_options[:include] ||= [:children,:elements,:parameter_types]
      Alces::XmlDeserializer.new(self,my_options ).to_object(xml)
 end
 
end
