# == Schema Information
# Schema version: 306
#
# Table name: data_types
#
#  id                 :integer(11)   not null, primary key
#  name               :string(255)   default(), not null
#  description        :string(1024)  default(), not null
#  value_class        :string(255)   
#  lock_version       :integer(11)   default(0), not null
#  created_at         :datetime      not null
#  updated_at         :datetime      not null
#  updated_by_user_id :integer(11)   default(1), not null
#  created_by_user_id :integer(11)   default(1), not null
#

##
# Copyright © 2006 Robert Shell, Alces Ltd All Rights Reserved
# See license agreement for additional rights
# 

class DataType < ActiveRecord::Base
   acts_as_dictionary :name 

##
# This record has a full audit log created for changes 
#   
  acts_as_audited :change_log
#
# Generic rules for a name and description to be present
  validates_presence_of :name
  validates_presence_of :description
  validates_uniqueness_of :name
  
##
#  In usage a DataType has a collection of DataFormat models which are used
#  to govern data entry. This is basically a managment library of regex masks
#  to in other forms.
#  
  has_many :data_formats, :dependent => :destroy
  has_many :parameters, :dependent => :destroy
  has_many :assay_parameters, :dependent => :destroy
  
end
