##
# Copyright � 2006 Robert Shell, Alces Ltd All Rights Reserved
# See license agreement for additional rights
##

#
# Main Application controller with a log of the key application aspects for
# user authorization, authentatations etc.
# 
class ApplicationController < ActionController::Base
 # observer :study_observer,:experiment_observer, :catalog_observer
 
 PUBLIC_PROJECT_ID = 1
 GUEST_USER_ID = 1
 
 #audit DataConcept,DataContext,DataSystem,DataElement,DataFormat,DataType,
 #      Study,StudyProtocol,StudyParameter,
 #      ProtocolVersion,ParameterContext,Parameter,
 #      Experiment,Task
 
##
# Help functionailty has been divided up into a number areas to keep modules readable 
  helper SortHelper    # Dynamic table sort
  helper FormHelper    # Various Form helper and custom controllers
  helper FormatHelper  # Extra formating rules for date,times etc
  helper SessionHelper # Various session/parameter cache and lookup function
  helper TreeHelper # Tree display helpers
  include SessionHelper # Various session/parameter cache and lookup function
  include TinyMCE
 
  include Biorails::CachingMethods

  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_Biorails2_session_id'

#  cattr_accessor :project_count
#  before_filter  :set_cache_root
#  helper_method  :project
#  attr_reader    :project


#set norfello style layout
# layout 'norfello'


  helper_method :logged_in?
  helper_method :current_user
  helper_method :current_project
  helper_method :current_username
  helper_method :current 

##
# is there a user logged in
#   
  def logged_in?
    !session[:current_user_id].nil?
  end
##
# Reference to the current User
#       
  def current_user
   logger.info("current_user ")
    if session[:current_user_id]
      @current_user = User.find(session[:current_user_id])
    else
      #@current_user = User.find(GUEST_USER_ID)
      return nil
    end
  end
##
# Current username
#   
  def current_username
     session[:current_username]
  end

##
# Reference to the current project
# 1st checks for a pass parameter of project_id
# 2nd checks for a session project_id
# 3rd find the object
#   
  def current_project
    if session[:current_project_id]  
       @current_project ||= Project.find(session[:current_project_id])
    else
       @current_project ||= Project.find(PUBLIC_PROJECT_ID)
    end
     logger.info("current_project #{@current_project.name}")
     return @current_project
  end


##
# Get current version of this model passed on param[:id] and
# if not found the current session
#
  def current(model,id=nil)
    logger.debug "current(#{model},#{id})"
    key = "#{model.to_s}_id"
    instance = model.find(id) if id
    instance ||= model.find(session[key]) if session[key]
    instance ||= current_user.lastest(model) if logged_in?
    session[key]= instance.id
    return instance
  rescue Exception => ex
      logger.error "current error: #{ex.message}"
      return lastest(model)
  end

##
# Default authorization function allow anything
#  
  def authorize
    return true
  end   

##
# Default authenticate i
#  
  def authenticate
    session[:current_params] = params
    unless logged_in?
      redirect_to :controller => "auth", :action => "login"
      return false
    end
    true
  end
  
  
protected   

##
# Set the Current user
# 
  def set_user(user)
      logger.info("set_user #{user.name}")
    if user  
      session[:current_user_id] = user.id    
      session[:current_username] = user.login
      @current_user = user
    end      
  end
  
  def clear_session
    session[:current_user_id] = nil
    session[:current_project_id] = nil
    session[:current_username] = 'none'
    session[:current_params] = nil
    @current_project = nil
    @current_user = nil
  end


  def set_project(project)
      logger.info("set_project #{project.name}")
      if project.member(current_user)
         session[:current_project_id] = project.id
         @current_project = project
      else
         show_access_denied      
      end
      return @current_project
  end  
##
# Test whether the user is logged_in
#   
  def show_login
      redirect_to auth_url(:action => "login")
      return false
  end
  
  def show_logout
      redirect_to auth_url(:action => "logout")
      return false
  end



  def rescue_action_in_public(exception)
      logger.debug "#{exception.class.name}: #{exception.to_s}"
      exception.backtrace.each { |t| logger.debug " > #{t}" }
      case exception
        when ActiveRecord::RecordNotFound, ::ActionController::UnknownController, ::ActionController::UnknownAction
          render :file => File.join(RAILS_ROOT, 'public/404.html'), :status => '404 Not Found'
        else
          render :file => File.join(RAILS_ROOT, 'public/500.html'), :status => '500 Error'
      end
  end

##
# Default report to build if none found in library
#    
  def report_list_for(name,model)
    report = Report.new
    report.model=model
    report.name = name || "#{model}List"
    report.description = "Default reports for display as /#{model.to_s}/list"
    report.column('id').is_visible = false
    return report
  end
##
# Generate a default report to display all the reports in the list of types
# 
  def reports_on_models(name,list)
   report = Report.new
   report.model = Report
   report.name = name
   report.description = "#{name} list of all #{list.join(',')} centric reports on the system"
   report.column('custom_sql').is_visible=false
   report.column('id').is_visible = false
   column = report.column('base_model')
   column.filter_operation = 'in'
   column.filter_text = "("+list.collect{|item|"'#{item.to_s}'"}.join(",")+")"
   column.is_filterible = false
   return report
  end
 

end  # class ApplicationController
