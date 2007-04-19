##
# Copyright © 2006 Robert Shell, Alces Ltd All Rights Reserved
# See license agreement for additional rights
##
#
##
# This is a generic report builder and runner for [http://biorails.org] it provides the ability to 
# generate a ActiveRecord style find query with included linked objects for the bases of the report.
# 
# This query is saved in Report and ReportColumn to create a reusable report defintion which can be
# reused.
# 
require "faster_csv"
require "csv"
class Execute::ReportsController < ApplicationController

  use_authorization :report,
                    :actions => [:list,:show,:new,:create,:edit,:update,:desrroy],
                    :rights => :current_user
                      

 COLOURS = ['#40e0d0','#ffffb3','#ffe4b5','#e6f5d0','#e6e6fa','#e0ffff','#ffefdb','#dcdcdc',
               '#ffe1ff','#ffe4b5','#ffe4c4','#ffe4e1','#ffffd9','#ffffe0','#ffffe5',
               '#fffff0','#ffec8b','#ffed6f','#ffeda0','#ffefd5','#ffefdb']
  
 GRAPHIZ_STYLES = ['dot','neato','twopi','fdp']
               

##
# List of created reports
# 
#  * params[id] filter down list for a single type of model
#
 def list
   @report = Report.find_by_name("ReportList") 
   unless @report
      @report = report_list_for("ReportList",Report)
      @report.column('custom_sql').is_visible=false 
      @report.save
   end  
   @report.params[:action]='run'
   @report.params[:controller]='reports'
   @report.set_filter(params[:filter])if  params[:filter] 
   @report.add_sort(params[:sort]) if params[:sort]
   @data = @report.run
 end

##
# Open the report builder
# 
 def builder
   render :redirect => 'new', :id => params[:id] 
 end

##
# Generate new report for a model
# 
#  * params[:id] optional name of the model to use as basis of report
#  
 def new
   @models = Biorails::UmlModel.models
   @allowed_models =  Biorails::UmlModel.models
   @report = Report.new(:name=> Identifier.next_id(Report))
   if params[:id]    
      @report.base_model = params[:id] if @allow_models.any?{|model|model[1]==params[:id]}         
   end
 end

 
##
#Create a new report and if this work jump to report editor to add custom columns 
#
# * params[:report] for the map of properties of the Report object to create
#
  def create
    @report = Report.new(params[:report])
    if @report.save
      @model = eval(@report.base_model)
      @report.model = @model
      flash[:notice] = 'Report was successfully created.'
      redirect_to :action => 'edit', :id => @report
    else
      render :action => 'new'
    end
  end
 
##
# Edit a existing report 
 def edit
   @report = Report.find(params[:id])  
   @has_many = true
   @data = @report.run(:limit=>10)
 end

##
# update the record with details from form input. This uses
# 
#  * params[:id] for the lookup of the Report
#  * params[:report][] for a map of Report properties to update
#  * params[:columns][][] as 2 level map of column name then properties
#  
 def update
   @report = Report.find(params[:id])
   @report.update_attributes(params[:report])
    puts "updated report"
    map = params[:columns]
    if map
      for key in map.keys
        puts "map column #{key} report"
        column = @report.column(key)
        column.customize(map[key])
        column.save
      end
    end
    flash[:notice] = 'Report was successfully updated.'
    redirect_to :action => 'edit', :id => @report
 end

##
# Show a report based on saved definition. This accepts further filters and sort details 
# 
#  * params[:id] id of the report to show
#  * params[:filter] is used as map parameter to filter {:status => 'low',:label => 'AB%'} 
#  * params[:sort] this is used to change the sort order for the columns e eg "name,label:desc"
# 
 def show
    @report = Report.find(params[:id])
    @snapshot_name = Identifier.next_id(current_user.login)
    @data_pages = Paginator.new self, 1000, 100, params[:page]
    @columns = @report.displayed_columns
    @data = @report.run({:limit  =>  @data_pages.items_per_page,
                          :offset =>  @data_pages.current.offset })
 end 
 
 
 
###
# Save a Run of a report to as ProjectContent for reporting
# 
 def snapshot
    @report = Report.find(params[:id])
    @data = @report.run    
    @html = render_to_string(:action=>'print', :layout => false)
    @project_folder  =ProjectFolder.find(params[:folder_id])
    @project_content = ProjectContent.new
    @project_content.name = params[:name]
    @project_content.title = params[:title]
    @project_content.body_html = @html
    @project_content.project = current_project
    if @project_content.save
        @project_element = @project_folder.add(@project_content)
        redirect_to folder_url( :action =>'show',:id=>@project_folder )
    else
        logger.warning @project_content.to_yaml
        render :inline => @html
    end
 end

 
  def visualize
    @report = Report.find(params[:id])
  end
   
  def destroy
    Report.find(params[:id]).destroy
    redirect_to :action => 'list'
 end
 ##
 # Alias for show
 # 
 def run
   show
   render :action =>'show'
 end
##
# for for Ajax refresh after a change to the filter or sort parameters
#  
 def refresh
    @report = Report.find(params[:id])
    @report.set_filter(params[:filter])if params[:filter] 
    @report.add_sort(params[:sort]) if params[:sort]

    @data_pages = Paginator.new self, 1000, 100, params[:page]
    @columns = @report.displayed_columns
    @data = @report.run({:limit  =>  @data_pages.items_per_page,
                          :offset =>  @data_pages.current.offset })
    render :partial=> 'shared/report_body', :locals => {:report => @report, :data =>@data } 
 end
  
##
# expand a element of the attribute tree
# 
#  * param[:id] 
#  * param[:link] 
# 
 def expand 
   @report = Report.find(params[:context])
   if params[:id]       
      @model = eval(params[:id])
      @link = params[:link]
      @current = @model
      elements =  @link.split(".")
      for element in elements
        relation = @current.reflections.find{|key,value|key.to_s == element}
        @current = eval(relation[1].class_name)
      end
      @link << "."
      @has_many = false
      render :partial => 'attribute_selector',
             :locals => {:root => @model, :link => @link, :model => @current }
   end
 end
#
#  export Report of Concepts as CVS
#  
def export
    @report = Report.find(params[:id])
    @columns = @report.displayed_columns
    output = StringIO.new
    CSV::Writer.generate(output, ',') do |csv|
      csv << @columns.collect{|col|col.label}
      for row in @report.run
        values = @columns.collect{ |column| [column.value(row)].flatten }
        max = values.collect{ |item| item.size}.max
        for item  in (0..max-1)
          csv << values.collect{ |value| value[item] }
        end 
      end
    end
    output.rewind
    send_data(output.read,
      :type => 'text/csv; charset=iso-8859-1; header=present',
      :filename => "report_#{@report.name}.csv")
  end  

##
# Refresh the columns in the report 
#
#  * params[:id] id of the report to show
#  * params[:filter] is used as map parameter to filter {:status => 'low',:label => 'AB%'} 
#  * params[:sort] this is used to change the sort order for the columns e eg "name,label:desc"
# 
 def refresh_columns
   @report = Report.find(params[:context])
   @report.set_filter(params[:filter])if params[:filter] 
   @report.add_sort(params[:sort]) if params[:sort]
   
   @successful=true
   return render(:action => 'refresh_report.rjs') if request.xhr?
   render :action=> 'edit', :id=>@report
 end

##
# customize details for a column
# 
 def update_column   
   @report = Report.find(params[:context])
   column = ReportColumn.find(params[:id])
   column.customize(params[:column])   
   @successful=column.save

   return render(:action => 'refresh_report.rjs') if request.xhr?
   render :action=> 'edit', :id=>@report
 end
 
##
# add a column to the report
# 
 def add_column
   @report = Report.find(params[:id])
   text = params[:column]
   text ||= request.raw_post || request.query_string
   logger.debug "add_column #{text}"
   column = @report.column(text.split("~")[1])
   @successful=column.save

   return render(:action => 'refresh_report.rjs') if request.xhr?
   render :action=> 'edit', :id=>@report
 end
 
##
# Remove a column from the report
#  
 def remove_column
   text = request.raw_post || request.query_string

   @report = Report.find(params[:context])
   column = ReportColumn.find(params[:id])
   @successful=column.destroy

   return render(:action => 'refresh_report.rjs') if request.xhr?
   render :action=> 'edit', :id=>@report
 end

end
