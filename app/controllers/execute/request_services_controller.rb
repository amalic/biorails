# == Request service controller 
# 
#
#
#
# == Copyright
# 
# Copyright © 2006 Robert Shell, Alces Ltd All Rights Reserved
# See license agreement for additional rights
#
#
class Execute::RequestServicesController < ApplicationController

  use_authorization :execution,
                    :actions => [:list,:show,:new,:create,:edit,:update,:destroy],
                    :rights => :current_user

  before_filter :setup_request_service, :only => [ :show, :edit, :update,:destroy,:results] 
  
  def index
    list
  end
#
# List of Requested services
#
  def list
     @request_services = RequestService.paginate :order=>'name', :page => params[:page]
    render :action => 'list'
  end
#
# Results for a set request
# 
  def results
   @report = Report.internal_report("Service Request Results",QueueResult) do | report |
      report.column('request_service_id').filter = @request_service.id.to_s
      report.set_filter(params[:filter])if params[:filter] 
      report.add_sort(params[:sort]) if params[:sort]
   end
   @data = @report.run(:page => params[:page])
   render :action => :report
  end
#
# Show a requested service to allow users to update the status and items
#
  def show
  end
#
# Default edit function not really used
#
  def edit
  end
#
# Update a service request
#
  def update
    if @request_service.update_attributes(params[:request_service])
      flash[:notice] = 'RequestService was successfully updated.'
      redirect_to :action => 'show', :id => @request_service
    else
      render :action => 'edit'
    end
  end
##
# Update the service 
# 
  def update_service
    logger.info "got service status_id= #{params[:status_id]} priority_id= #{params[:priority_id]}"
    RequestService.transaction do 
      @request_service = RequestService.find(params[:id])
      @request_service.update_state(params)
      @request_service.items.each do |item| 
         item.update_state(params)
         item.save
      end   
      @request_service.save
    end
    respond_to do | format |
      format.html { redirect_to :action => 'show', :id => @request_service }
      format.js   { render :update do | page |
        for item in @request_service.items
          page.replace_html item.dom_id(:updated_at), :partial => 'queue_item',:locals => { :queue_item => item } 
          page.visual_effect :highlight, item.dom_id(:updated_at),:duration => 1.5
        end
      end }
      format.json { render :json => @request_service.to_json }
      format.xml  { render :xml => @request_service.to_xml }
    end
  end

##
# Update a single service queue item
# 
  def update_item
    logger.debug "got item status_id= #{params[:status_id]} priority_id= #{params[:priority_id]}"
    RequestService.transaction do 
      @queue_item = QueueItem.find(params[:id])
      @queue_item.update_state(params)
      @queue_item.save
      @request_service = @queue_item.service
    end
    respond_to do | format |
      format.html { redirect_to :action => 'show', :id => @request_service }
      format.js   { render :update do | page |
          page.replace_html @queue_item.dom_id(:updated_at), :partial => 'queue_item',:locals => { :queue_item => @queue_item } 
          page.visual_effect :highlight, @queue_item.dom_id(:updated_at),:duration => 1.5
      end }
      format.json { render :json => @request_service.to_json }
      format.xml  { render :xml => @request_service.to_xml }
    end
  end
  ##
  # Remove the request service
  #
  def destroy
    @user_request = @request_service.request
    @request_service.destroy
    redirect_to request_url(:action => 'show', :id=>@user_request.id)
  end
  ##
  # Remove a item from a service
  # 
  def destroy_item
    QueueItem.find(params[:item_id]).destroy
    @request_service = RequestService.find(params[:id])
    redirect_to service_url(:action => 'show', :id=> @request_service.id)
  end

protected

  def setup_request_service
     @request_service = RequestService.find(params[:id])
     return show_access_denied unless @request_service   
     @project_folder =@request_service.request.folder
     return true
  rescue
     return show_access_denied
  end  
  
end
