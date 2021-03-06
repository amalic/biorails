# == Schema Information
# Schema version: 306
#
# Table name: plates
#
#  id                 :integer(11)   not null, primary key
#  name               :string(255)   not null
#  description        :string(1024)  default(), not null
#  external_ref       :string(255)   
#  quantity_unit      :string(255)   
#  quantity_value     :float         
#  url                :string(255)   
#  lock_version       :integer(11)   default(0), not null
#  created_at         :datetime      not null
#  updated_at         :datetime      not null
#  updated_by_user_id :integer(11)   default(1), not null
#  created_by_user_id :integer(11)   default(1), not null
#

##
# Copyright © 2006 Robert Shell, Alces Ltd All Rights Reserved
# See license agreement for additional rights
##
#

class Plate < ActiveRecord::Base
   acts_as_dictionary :name 
##
# This record has a full audit log created for changes 
#   
  acts_as_audited :change_log
#
# Generic rules for a name and description to be present
  validates_presence_of :name
  validates_presence_of :description
  
end
