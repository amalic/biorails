class Project::ProjectsController < ApplicationController

  use_authorization :project,
                    :actions => [:list,:show,:new,:create,:edit,:update,:destroy],
                    :rights =>  :current_project  

  helper :calendar
  
  in_place_edit_for :project, :name
  in_place_edit_for :project, :summary
##
# Generate a index dashboard for the project 
#   
  def index
    @projects = User.current.projects
  end

##
# Generate a index dashboard for the project 
#  
  def show
    @project =  current_user.project(params[:id])
    set_project(@project)    
    respond_to do | format |
      format.html { render :action => 'show'}
      format.xml {render :xml =>  @project.to_xml(:include=>[:memberships,:folders,:studies,:experiments,:tasks])}
    end

  end

  def new
    @project = Project.new
    @user = current_user
  end

  def create
    Project.transaction do
      @user = current_user    
      @project = current_user.create_project(params['project'])
      @project.summary = params[:project][:summary]
      if @project.save
        flash[:notice] = "Project was successfully created."
        set_project(@project)
        redirect_to  :action => 'show',:id => @project      
      else
        render :action => 'new'
      end
    end
  end

  def edit
    @project = current_user.project(params[:id])
    respond_to do | format |
      format.html { render :action => 'edit'}
      format.xml {render :xml =>  @project.to_xml}
    end
  end

  def update
    Project.transaction do
      @project = current_user.project(params[:id])
      if @project.update_attributes(params[:sample])
        flash[:notice] = 'Sample was successfully updated.'
        redirect_to :action => 'show', :id => @project
      else
        render :action => 'edit'
      end
    end
  end
  
##
# Destroy a study
#
  def destroy
    current_user.project(params[:id]).destroy
    set_project(Project.find(1))    
    redirect_to home_url(:action => 'show')
  end  

##
# List of the membership of the project
# 
  def members
     @project = current_user.project(params[:id])
     @membership = Membership.new(:project_id=>@project)
    respond_to do | format |
      format.html { render :action => 'members'}
      format.xml {render :xml =>  @project.to_xml(:include =>[:memberships,:owners,:users])}
    end
  end
##
# Show a overview calendar for the project this should list the experiments, documents etc linked into the project
# 
  def calendar
     @project = current_user.project(params[:id])
 
     @options ={ 'month' => Date.today.month,
                'year'=> Date.today.year,
                'items'=> {'task'=>1},
                'states' =>{'0'=>0,'1'=>1,'2'=>2,'3'=>3,'4'=>4} }.merge(params)
 
    logger.info " Calendar for #{@options.to_yaml}"

    started = Date.civil(@options['year'].to_i,@options['month'].to_i,1)   

    find_options = {:conditions=> "status_id in ( #{ @options['states'].keys.join(',') } )"}

    @calendar = CalendarData.new(started,1)
    @project.tasks.add_into(@calendar,find_options)               if @options['items']['task']
    @project.experiments.add_into(@calendar,find_options)         if @options['items']['experiment']
    @project.studies.add_into(@calendar,find_options)             if @options['items']['study']
    @project.requests.add_into(@calendar,find_options)            if @options['items']['request']
    @project.requested_services.add_into(@calendar,find_options)     if @options['items']['service']
    @project.queue_items.add_into(@calendar,find_options)         if @options['items']['queue']

    respond_to do | format |
      format.html { render :action => 'calendar' }
      format.json { render :json => {:project=> @project, :items=>@calendar.items}.to_json }
      format.xml  { render :xml => {:project=> @project,:items=>@calendar.items}.to_xml }
      format.js   { render :update do | page |
           page.replace_html 'centre',  :partial => 'calendar' 
           page.replace_html 'right',  :partial => 'calendar_right' 
         end }
      format.ics  { render :text => @calendar.to_ical}
    end
  end  

##
# Display of Gantt chart of task in  the project
# This will need to show studies,experiments and tasks in order
#   
  def gantt
     @project = current_user.project(params[:id])
     @options ={ 'month' => Date.today.month,
                'year'=> Date.today.year,
                'items'=> {'task'=>1},
                'states' =>{'0'=>0,'1'=>1,'2'=>2,'3'=>3,'4'=>4} }.merge(params)
    find_options = {:conditions=> "status_id in ( #{ @options['states'].keys.join(',') } )"}
                    
    if params[:year] and params[:year].to_i >0
      @year_from = params[:year].to_i
      if params[:month] and params[:month].to_i >=1 and params[:month].to_i <= 12
        @month_from = params[:month].to_i
      else
        @month_from = 1
      end
    else
      @month_from ||= (Date.today << 1).month
      @year_from ||= (Date.today << 1).year
    end
    
    @zoom = (params[:zoom].to_i > 0 and params[:zoom].to_i < 5) ? params[:zoom].to_i : 2
    @months = (params[:months].to_i > 0 and params[:months].to_i < 25) ? params[:months].to_i : 6
    
    @date_from = Date.civil(@year_from, @month_from, 1)
    @date_to = (@date_from >> @months) - 1
    @tasks = @project.tasks.range( @date_from, @date_to,50,find_options)  
    
    @options_for_rfpdf ||= {}
    @options_for_rfpdf[:file_name] = "gantt.pdf"
    respond_to do | format |
      format.html { render :action => 'gantt' }
      format.ext { render :action => 'gantt', :layout => false }
      format.pdf { render :action => "gantt_print.rfpdf", :layout => false }
      format.json { render :json => {:project=> @project, :items=>@tasks}.to_json }
      format.xml  { render :xml =>  {:project=> @project,:items=>@tasks}.to_xml }
      format.js   { render :update do | page |
           page.replace_html 'centre',  :partial => 'gantt' 
         end }
    end
  end


end
