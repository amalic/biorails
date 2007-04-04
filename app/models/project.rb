# == Schema Information
# Schema version: 233
#
# Table name: projects
#
#  id                 :integer(11)   not null, primary key
#  name               :string(30)    default(), not null
#  summary            :text          default(), not null
#  status_id          :integer(11)   default(0), not null
#  title              :string(255)   
#  subtitle           :string(255)   
#  email              :string(255)   
#  ping_urls          :text          
#  articles_per_page  :integer(11)   default(15)
#  host               :string(255)   
#  akismet_key        :string(100)   
#  akismet_url        :string(255)   
#  approve_comments   :boolean(1)    
#  comment_age        :integer(11)   
#  timezone           :string(255)   
#  filter             :string(255)   
#  permalink_style    :string(255)   
#  search_path        :string(255)   
#  tag_path           :string(255)   
#  search_layout      :string(255)   
#  tag_layout         :string(255)   
#  current_theme_path :string(255)   
#  created_by         :string(32)    default(sys), not null
#  created_at         :datetime      not null
#  updated_by         :string(32)    default(sys), not null
#  updated_at         :datetime      not null
#

##
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
  cattr_accessor :multi_projects_enabled
  cattr_accessor :cache_sweeper_tracing

  validates_uniqueness_of :name
  validates_presence_of :name
  validates_presence_of :summary
  validates_presence_of :status_id 

  ##
  # Link to Document Management repository (subversion,documentum etc)
  # belongs_to :repository, :class_name => 'Repository', :foreign_key=>'repository_id'

##
# Link through to users for members, and owners via memberships
# 
  has_many :memberships, :dependent => :destroy
  has_many :members, :through => :memberships, :source => :user
  has_many :owners,  :through => :memberships, :source => :user, :conditions => ['memberships.owner = ? or users.admin = ?', true, true]

##
# Unstructurted data is mapped into a set of folders for the project. For anotement of  models 
# a folder is referenced to a model. A number of short cuts are provided to help 
# 
#  * project.folders.notes(object) => folder for unstructed information linked to the object
#  * project.folders.linked_to(model) => array of folders linked to a model type
#  * project.folders.studies
#  * project.folders.experiments
#  * project.folders.tasks
#  
#
  has_many  :folders, :class_name=>'ProjectFolder', :order => "position", :conditions => 'parent_id is null' do

    def home
      ProjectFolder.find(:first,
           :conditions=>["project_id= ? and refererence_id=? and project_folders.reference_type='Project'",proxy_owner.id,proxy_owner.id])
    end
##
# Get folder for notes associated with a object
    def notes(object)
      ProjectFolder.find(:first,
           :conditions=>["project_id= ? and reference_id=? and reference_type=?",
                          proxy_owner.id,object.id,  object.class.to_s] )
    end
##
# Get a list of a folders linked to a model
    def linked_to(model)
      ProjectFolder.find(:all,
           :conditions=>["project_id= ? and reference_type=?",proxy_owner.id, model.to_s] )
    end

    def studies
       linked_to('Study')
    end

    def experiments
       linked_to('Experiement')
    end

    def tasks
       linked_to('Task')
    end

    def requests
       linked_to('Request')
    end

    # orders sections in a project
    def order!(*sorted_ids)
      transaction do
        sorted_ids.flatten.each_with_index do |section_id, pos|
          Section.update_all ['position = ?', pos], ['id = ? and project_id = ?', section_id, proxy_owner.id]
        end
      end
    end
  end

##
# Create a project root folder after create of project
# 
  after_create do  |project| 
     folder = project.folder(project) # Create a / root folder for the project
  end

##
# List of assets associated with the the project in reverse order
# thumbnails etc are children of the root Assets
# 
  has_many  :assets, :class_name=>'ProjectAsset', :order => 'created_at desc', :conditions => 'parent_id is null' do

    def images
      find(:first,
           :conditions=>["project_id=? and content_type like 'image%'",proxy_owner.id])
    end

    def content(type)
      if type.class==Array
           find(:all,
                :conditions=>["project_id=? and content_type in ? ",proxy_owner.id,type])
      else
           find(:all,
                :conditions=>["project_id=? and content_type like ? ",proxy_owner.id,type])
      end
    end

  end
##
# List of all articles associated with a the project in reverse order
# 
  has_many  :articles, :class_name=>'ProjectContent', :order => 'created_at desc' do
    def find_by_permalink(options)
      conditions = 
        returning ["(contents.published_at IS NOT NULL AND contents.published_at <= ?)", Time.now.utc] do |cond|
          if options[:year]
            from, to = Time.delta(options[:year], options[:month], options[:day])
            cond.first << ' AND (contents.published_at BETWEEN ? AND ?)'
            cond << from << to
          end
          
          [:id, :permalink].each do |attr|
            if options[attr]
              cond.first << " AND (contents.#{attr} = ?)"
              cond << options[attr]
            end
          end
        end
      
      find :first, :conditions => conditions, :order => 'published_at desc'
    end
  end
  
###
# Set a user as a owner of the project
#  
  def owner=(user)
    membership = Membership.new
    membership.user =user
    membership.role =user.role
    membership.project = self
    membership.owner = true
    membership.save    
  end
##
# Get the member details
#  
  def member(user)
    Membership.find(:first,:conditions=>['project_id=? and user_id=?',self.id,user.id],:include=>:role)
  end

 ###
 # Get the lastest n record of a type linked to this project. This allows simple discovery 
 # of changes to linked records   
 # 
  def lastest(model = ProjectContent, count=5)    
    if model.columns.any?{|c|c.name=='project_id'} and model.columns.any?{|c|c.name=='updated_at'}
       model.find(:all,:conditions => ['project_id=?',self.id] ,:order=>'updated_at desc',:limit => count)  
    elsif model.columns.any?{|c|c.name=='updated_at'}
       model.find(:all, :order=>'updated_at desc',:limit => count)
    else
      model.find(:all,:order=>'id desc',:limit => count)
    end
  end

 
  ##
  # Get all Tags used in the project
  # 
  def tags
    Tag.find(:all, :select      => "DISTINCT tags.name",
                   :joins       => "INNER JOIN taggings ON taggings.tag_id = tags.id INNER JOIN contents ON (taggings.taggable_id = contents.id AND 
                                    taggings.taggable_type = 'Content')",
                   :conditions  => ['contents.type = ? AND contents.project_id = ?', 'Article', id],
                   :order       => 'tags.name')
  end

##
# Get a root folder my name 
# 
  def folder?(item)
    if item.is_a?  ActiveRecord::Base
       ProjectFolder.find(:first,:conditions=>['project_id=? and name=?',self.id,item.name.to_s])
    else
       ProjectFolder.find(:first,:conditions=>['project_id=? and name=?',self.id,item.to_s])
    end
  end
##
#Get a folder by path
#
  def path?(path)
    ProjectFolder.find(:first,:conditions=>['project_id=? and path=?',self.id,path.to_s])
  end

##
# add/find a folder to the project. This  
# 
  def folder(item)
    folder = folder?(item)
    if folder.nil? 
      folder = ProjectFolder.new(:project_id=>self.id)
      if item == self
         folder.name = '/'
         folder.reference =  item
         folder.path = self.name
      
      elsif item.is_a?  ActiveRecord::Base
         folder.name = item.name
         folder.reference =  item
         folder.path = self.name+"/"+folder.name
         
      else
         folder.name = item.to_s
         folder.path = self.name+"/"+folder.name
      end
      folder.position = folders.size
      folders << folder
    end
    return folder
  end

 

##
# path for attachmented to be saved under
  def attachment_path
    SystemSetting.get('attachment_path') 
  end

  def tag_url(*tags)
    ['', tag_path, *tags] * '/'
  end

  def accept_comments?
    comment_age.to_i > -1
  end

  def owner=(user)
  end
  
  def owner?(user)
  end
  
  def member?(user)
  end
  
  
  protected


  
end
