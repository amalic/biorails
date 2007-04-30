# == Schema Information
# Schema version: 239
#
# Table name: users
#
#  id               :integer(11)   not null, primary key
#  name             :string(255)   default(), not null
#  password_hash    :string(40)    
#  role_id          :integer(11)   not null
#  password_salt    :string(255)   
#  fullname         :string(255)   
#  email            :string(255)   
#  login            :string(40)    
#  activation_code  :string(40)    
#  state_id         :integer(11)   
#  activated_at     :datetime      
#  token            :string(255)   
#  token_expires_at :datetime      
#  filter           :string(255)   
#  admin            :boolean(1)    
#  created_at       :datetime      
#  updated_at       :datetime      
#  deleted_at       :datetime      
#

require 'digest/sha1'

##
# User record
# 
# The user is a member of a number of projects. In a project the membership governs by a role 
class User < ActiveRecord::Base

  DEFAULT_GUEST_USER_ID = 1
##
# Populated in Application controller with current user for the transaction
# @todo RJS keep a eye on threading models in post 1.2 Rails to make sure this keeps working 
#
  cattr_accessor :current_user
##
# Do user authorization and authentication has been moded to a plugin
# 
# In implementation alces_access_control plugin to customize authorization and
# authenication functions. To allow delegation to LDAP, OS etc.
# 
  access_authenticated  :username => :login, 
                        :passsword => :password_hash
                           
  access_control_rights :role                      
##
# Business Rules for a user
# 
  attr_accessor :password
#  attr_accessor :password_conformation

  validates_presence_of   :name
  validates_presence_of   :role

  validates_length_of     :login, :within => 3..40
  validates_format_of     :login, :with => /^[a-z0-9_\-@\.]+$/i
  validates_uniqueness_of :login, :case_sensitve => false

#  validates_presence_of   :password_hash
#  validates_length_of     :password, :in => 4..12, :allow_nil => true

# validates_format_of   :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i

##
# User a linked into projects
#   
  has_many   :projects, :through=>:memberships, :order => 'name' 
##
# Has membership of a a number of projects with a set role in each
#   
  has_many   :memberships, :include => [ :project, :role ], :dependent => :delete_all
##
# Users are linked into the system as a the owner of a number of record types
# 
  has_many :requests ,   :class_name=>'Request',      :foreign_key=> 'requested_by_user_id'
  has_many :studies ,    :class_name=>'Study',        :foreign_key=> 'created_by_user_id'
  has_many :protocols ,  :class_name=>'StudyProtocol',:foreign_key=> 'created_by_user_id'

  has_many_scheduled :requested_services ,:class_name=>'RequestService', :foreign_key=> 'requested_by_user_id'  
  has_many_scheduled :experiments ,:class_name=>'Experiment',   :foreign_key=> 'created_by_user_id'  
  has_many_scheduled :tasks ,      :class_name=>'Task',         :foreign_key=> 'assigned_to_user_id'   
  has_many_scheduled :queue_items, :class_name=>'QueueItem',    :foreign_key=> 'assigned_to_user_id'
##
# unstructured data
# 
  has_many :articles, :class_name=>'ProjectContent', :foreign_key=> 'created_by_user_id'
  has_many :files,    :class_name=>'ProjectAsset',   :foreign_key=> 'created_by_user_id'  
##
# Has a record of all the changes they have performed

  has_many :audits  

##
# This record has a full audit log created for changes 
#   
  acts_as_audited :change_log
  
#  acts_as_paranoid
##
# Class level methods
# 
  # Returns the user that matches provided login and password, or nil
  def self.login(username, password)
    user = User.authorized(username, password)
    if user
       logger.info "#{username} is a known username"
    else
       logger.info "#{username} is a not known"
    end
  end

##
# Create a new Project owned by this user
# 
  def create_project(name)
     Project.transaction do 
       project = Project.new(:name=>name)
       project.summary = "New Project #{name} created by user #{self.name}"
       project.owner = self
       if project.save     
           self.memberships.create(:project_id =>project.id,:role_id=>self.role,:owner=>true)
       end
       return project
     end
  end

##
# reset the password for the user
   def reset_password( old_value, new_value )
      if authenticated?(old_value)
        self.set_password(new_value)
      end
   end  
###
# Get the lastest n record of a type linked to this user   
# 
  def lastest(model = Task, count=5, field=nil)
    if field and model.columns.any?{|c|c.name==field.to_s} and model.columns.any?{|c|c.name=='updated_at'}
       model.find(:all,:conditions => [field.to_s,self.id] , :order=>'updated_at desc',:limit => count)
       
    elsif model.columns.any?{|c|c.name=='assigned_to_user_id'} and model.columns.any?{|c|c.name=='updated_at'}
       model.find(:all,:conditions => ['assigned_to_user_id=?',self.id] , :order=>'updated_at desc',:limit => count)
       
    elsif model.columns.any?{|c|c.name=='requested_by_user_id'} and model.columns.any?{|c|c.name=='updated_at'}
       model.find(:all,:conditions => ['requested_by_user_id=?',self.id] ,:order=>'updated_at desc',:limit => count)
       
    elsif model.columns.any?{|c|c.name=='updated_by_user_id'} and model.columns.any?{|c|c.name=='updated_at'}
       model.find(:all,:conditions => ['updated_by_user_id=?',self.id], :order=>'updated_at desc',:limit => count)
       
    elsif model.columns.any?{|c|c.name=='created_by_user_id'} and model.columns.any?{|c|c.name=='updated_at'}
       model.find(:all,:conditions => ['created_by_user_id=?',self.id] ,  :order=>'updated_at desc',:limit => count)
       
    else
      model.find(:all,:order=>'id desc',:limit => count)
    end
  end
 
##
# get the role for the user in a role
#  
  def membership(project)
    Membership.find(:first,:conditions=>['project_id=? and user_id=?',self.id,user.id],:include=>:role)
  end	
 
##
# Test in the user is authorized for a subject and action in a project
#  	
  def authorized?(subject,action)
    membership = membership(project)
    if membership.nil?
       return self.admin  # Your not a member
    else
       return membership.allow?(subject,action)
    end
  end 	  
  
  def User.current
    User.current_user || User.find(DEFAULT_GUEST_USER_ID)
  end

  def User.selector
     User.find(:all).collect{|item|[item.name,item.id]}
  end
  
end


