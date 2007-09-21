# == Schema Information
# Schema version: 280
#
# Table name: catalog_logs
#
#  id             :integer(11)   not null, primary key
#  user_id        :integer(11)   
#  auditable_id   :integer(11)   
#  auditable_type :string(255)   
#  action         :string(255)   
#  name           :string(255)   
#  comments       :string(255)   
#  created_by     :string(255)   
#  created_at     :datetime      
#

##
# Copyright © 2006 Robert Shell, Alces Ltd All Rights Reserved
# See license agreement for additional rights
# 
class CatalogLog < ActiveRecord::Base

  belongs_to :auditable, :polymorphic => true
  belongs_to :user

end
