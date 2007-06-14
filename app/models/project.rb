# == Schema Information
# Schema version: 239
#
# Table name: projects
#
#  id                 :integer(11)   not null, primary key
#  name               :string(30)    default(), not null
#  summary            :text          default(), not null
#  status_id          :integer(11)   default(0), not null
#  title              :string(255)   
#  email              :string(255)   
#  host               :string(255)   
#  comment_age        :integer(11)   
#  timezone           :string(255)   
#  created_at         :datetime      not null
#  updated_at         :datetime      not null
#  started_at         :datetime      
#  ended_at           :datetime      
#  expected_date      :datetime      
#  done_hours         :float         
#  expected_hours     :float         
#  updated_by_user_id :integer(11)   default(1), not null
#  created_by_user_id :integer(11)   default(1), not null
#

#
# This is the only web root path and investigation log for project.
# The Projects is build of organizational elements (Studies/Protocols/Services)
# execution elements covering the capture of data (experiments/tasks)
# and documentation build of a number of sections containing articles,assets,comments,reports etc.
# 
# Then the whole system is split into a internal view managed my members of the project and a public view 
# seen by subscribers.
#  
require 'tzinfo'

class Project < ActiveRecord::Base

  DEFAULT_PROJECT_ID = 1
##
# Populated in Application controller with current user for the transaction
# @todo RJS keep a eye on threading models in post 1.2 Rails to make sure this keeps working 
#
  cattr_accessor :current_project

  validates_uniqueness_of :name
  validates_presence_of :name
  validates_presence_of :summary
  validates_presence_of :status_id 
#
# This record has a full audit log created for changes 
#   
  acts_as_audited :change_log
 #
 # Add name and description to free text indexing systems
 #
  acts_as_ferret  :fields => {:name =>{:boost=>2,:store=>:yes} , 
                              :description=>{:store=>:yes,:boost=>0},
                               }, 
                   :default_field => [:name],           
                   :single_index => true, 
                   :store_class_name => true 
#
# Link through to users for members, and owners via memberships
# 
  access_control_list  :memberships , :dependent => :destroy 

  has_many :users, :through => :memberships, :source => :user
#
# People to share the ownership of project and so govern the membership
#
  has_many :owners,  :through => :memberships, :source => :user, :conditions => ['memberships.owner = ? or users.admin = ?', true, true]
#
# home folders
# 
  has_one :home_folder, :class_name=>'ProjectFolder', :conditions => 'parent_id is null'
#
# list of all folders in the project 
# 
  has_many :reports, :class_name=>'Report',:foreign_key =>'project_id',:order=>'name', :dependent => :destroy 
#
# List of all the folders in the project
#
  has_many :folders, :class_name=>'ProjectFolder',:foreign_key =>'project_id',:order=>'left_limit,parent_id,name', :dependent => :destroy 
#
# List of all the elements 
#
  has_many :elements, :class_name=>'ProjectElement',:foreign_key =>'project_id',:order=>'left_limit,parent_id,name', :dependent => :destroy 

#
# The project is the main holder of schedules but in turn can be seen on a system schedule
#   
  acts_as_scheduled :summary=>:tasks

  has_many_scheduled :studies,      :class_name=>'Study',:foreign_key =>'project_id', :dependent => :destroy 
  has_many_scheduled :experiments,  :class_name=>'Experiment',  :foreign_key =>'project_id', :dependent => :destroy 
  has_many_scheduled :tasks,        :class_name=>'Task',  :foreign_key =>'project_id', :dependent => :destroy 

  has_many :protocols, :through => :studies, :source => :protocols

##
# List of assets associated with the the project in reverse order
# thumbnails etc are children of the root Assets
# 
  has_many  :assets, :class_name=>'ProjectAsset', :order => 'created_at desc', :dependent => :destroy , :conditions => 'parent_id is null' do
    def images
      find(:first, :conditions=>["project_id=? and content_type like 'image%'",proxy_owner.id])
    end

    def content(type)
      if type.class==Array
           find(:all, :conditions=>["project_id=? and content_type in ? ",proxy_owner.id,type])
      else
           find(:all,:conditions=>["project_id=? and content_type like ? ",proxy_owner.id,type])
      end
    end
  end
##
# List of all articles associated with a the project in reverse order
# 
  has_many  :articles, :class_name=>'ProjectContent', :order => 'created_at desc', :dependent => :destroy 
#
# Create a project root folder after create of project
# 
  after_create do  |project| 
     create_home_folder(project)
  end
#
# On rename of the project change the folder name
#
def before_update
    ref = self.home
    if ref.name !=self.name
      ref.name = self.name
      ref.save!
    end
end
#
# List of all the users who are not a member of the project
# 
  def non_members
    User.find(:all,:conditions=>[" not exists (select 1 from memberships where memberships.project_id=? and memberships.user_id=users.id)",self.id] )    
  end
##
# get the home folder for the project creating it if none exists
#   
  def home
     return self.home_folder  if self.home_folder
     Project.create_home_folder(self)
  end
#
# Summary description of the project
#
  def description
    self.summary
  end
  
  def in_use?
    (self.elements.size>1 || self.studies.size>0)
  end
#
# Get the member details
#  
  def member(user)
    Membership.find(:first,:conditions=>['project_id=? and user_id=?',self.id,user.id],:include=>:role)
  end
#
# test wheather is the the owner of the project
#
  def owner?(user)
    member_details = Membership.find(:first,:conditions=>['project_id=? and user_id=?',self.id,user.id],:include=>:role)
    return (member_details and member_details.owner)
  end
  
  def news(count =5 )
    ProjectContent.find(:all,:conditions => ["project_id=? and content_id is not null",self.id] , :order=>'updated_at desc',:limit => count)   
  end
  
 #
 # Get the lastest n record of a type linked to this project. This allows simple discovery 
 # of changes to linked records   
 # 
  def lastest(model = ProjectElement , count=5, field=nil)
    if model.columns.any?{|c|c.name=='project_id'} and model.columns.any?{|c|c.name=='updated_at'}
       model.find(:all,:conditions => ['project_id=?',self.id] ,:order=>'updated_at desc',:limit => count)  
       
    elsif field and model.columns.any?{|c|c.name==field.to_s} and model.columns.any?{|c|c.name=='updated_at'}
       model.find(:all,:conditions => ["#{field.to_s}=?",self.id] , :order=>'updated_at desc',:limit => count)
       
    elsif model.columns.any?{|c|c.name=='updated_at'}
       model.find(:all, :order=>'updated_at desc',:limit => count)
    else
      model.find(:all,:order=>'id desc',:limit => count)
    end
  end

#
# Get a root folder my name 
# 
  def folder?(item)
    return self.home.folder?(item)
  end    
#
# Add/find a folder to the project. This  is delegated down to the root folder now
# 
  def folder(item)
    return home.folder(item)    
  end
#
# folders a options list for html forms
#
  def folder_options
     folders.collect do |folder|
        [folder.path,folder.id] 
     end
  end
#
#Get a folder by path
#
  def path?(path)
    ProjectElement.find(:first,:conditions=>['project_id=? and path=?',self.id,path.to_s])
  end
#
# Get a list of a folders linked to a model
# 
  def folders_for(model)
    ProjectFolder.find(:all, :conditions=>["project_id= ? and reference_type=?",self.id, model.to_s] )
  end
#
# Helper to return the current active project 
# 
  def Project.current
    Project.current_project || Project.find(DEFAULT_PROJECT_ID)
  end
#
# Get a study for this user, limits to projects the user is a member of
#  
  def study(*args)
    studies.find(*args)
  end
#
# Get a study for this user, limits to projects the user is a member of
#  
  def protocol(*args)
    StudyProtocol.with_scope( :find => {
         :conditions=> ['exists (select 1 from studies s where s.id=study_protocols.study_id and s.project_id=?)',self.id]
        })  do
       StudyProtocol.find(*args)
    end
  end
#
# Get a experiment for this user, limits to projects the user is a member of
#  
  def experiment(*args)
     experiments.find(*args)
  end
#
# Get a task for this user, limits to projects the user is a member of
#
  def task(*args)
     tasks.find(*args)
  end
  
protected 

  def Project.create_home_folder(project)
     home_folder = ProjectFolder.new(:project_id=>project.id)
     home_folder.name = project.name
     logger.info home_folder.to_yaml
     home_folder.save
     home_folder
  end
  
end
