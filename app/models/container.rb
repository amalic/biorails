# == Schema Information
# Schema version: 306
#
# Table name: containers
#
#  id                 :integer(11)   not null, primary key
#  name               :string(128)   default(), not null
#  description        :string(1024)  default(), not null
#  plate_format_id    :integer(11)   
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

class Container < ActiveRecord::Base
   acts_as_dictionary :name 
##
# This record has a full audit log created for changes 
#   
  acts_as_audited :change_log
  acts_as_ferret  :fields => {:name =>{:boost=>2,:store=>:yes} , 
                              :description=>{:store=>:yes,:boost=>0},
                              }, 
                   :default_field => [:name],           
                   :single_index => true, 
                   :store_class_name => true 

#
# Generic rules for a name and description to be present
  validates_presence_of :name
  validates_presence_of :description
  
 

end

