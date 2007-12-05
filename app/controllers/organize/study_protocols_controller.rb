##
# Copyright © 2006 Robert Shell, Alces Ltd All Rights Reserved
# See license agreement for additional rights
##
#
class Organize::StudyProtocolsController < ApplicationController
  use_authorization :study_protocols,
                    :actions => [:list,:show,:new,:create,:edit,:update,:destroy],
                    :rights => :current_project
                      

  helper SheetHelper
  
  in_place_edit_for :parameter_context,:label
  in_place_edit_for :parameter_context,:default_count
  in_place_edit_for :parameter, :name
  in_place_edit_for :parameter, :mandatory
  in_place_edit_for :parameter, :default_value
  
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

##
#List the protocols in the study
#
  def list
	if params[:id]
      @study = current_user.study( params[:id] )
      @study_protocols = @study.protocols
	else
      @study_protocols = current_project.protocols	  
	end  
  end

##
#Set the release protocol version
#
  def release
    @study_protocol = current_user.protocol( params[:id])
    @study_protocol.process = @study_protocol.lastest
    @study_protocol.save
    redirect_to :action => 'list', :id => @study_protocol.study
  end

##
# Show details for a protocol
# 
  def show
    find_process
    @folder = set_folder(@study_protocol.folder)
    respond_to do | format |
      format.html { render :action => 'show' }
      format.json { render :json => @study_protocol.to_json }
      format.xml  { render :xml =>  @study_protocol.to_xml(:except=>[:study]) }
      format.js   { render :update do | page |
           page.replace_html 'center',  :partial => 'show' 
           page.replace_html 'messages',  :partial => 'shared/messages' 
         end }
    end  end

  def metrics
    find_process
  end
  
  def analysis
    find_process
    AnalysisMethod.add_processor(Alces::Processor::PlotXy)
    @level1 =  @protocol_version.parameters.reject{|i|i.context.parent.nil?}.collect{|i|[i.name,i.id]}
    @level0 =  @protocol_version.parameters.reject{|i|!i.context.parent.nil?}.collect{|i|[i.name,i.id]}
    @processor = AnalysisMethod.processor("alces/processor/plot_xy")
    @analysis = @processor.setup if @processor
    @analysis ||= AnalysisMethod.new
  end

##
# Puts up the form for a new protocol, this created new Protocol, ProtocolVersion objects
# and open the edit form all all.
# 
  def new
    @study = current_user.study(params[:id])
    @study_protocol = StudyProtocol.new(:study=>@study)
    @study_protocol.name = Identifier.next_id(StudyProtocol)
    @study_protocol.protocol_catagory = 'Protocol'
    @study_protocol.description = "new protocol created for study "+@study.name   
  end

##
# Create new Study Protocol and linked ProcessDefinition and ProtocolVersion
# This routine expects a params[:study_protocol] to provide the basic data needed for this
# this completes step 1 in definition of study protocol. If this works control is 
# passed to the standard protocol editor
#
  def create
    @study = current_user.study(params[:id])   
    @study_protocol = StudyProtocol.new(params[:study_protocol])
    if @study_protocol.save
      @project_folder = @study_protocol.folder
      @study_protocol.process = @study_protocol.new_version     
      @parameter_context = @study_protocol.process.new_context
      @study_protocol.process.save
      @study_protocol.save
      @parameter_context.save
      flash[:notice] = 'StudyProtocol was successfully created.'
      redirect_to :action => 'layout', :id => @study_protocol
    else  
      render :action => 'new', :id => @study
     end
  end

###
# Edit the protocol creating a new version of the instance if the protocol is in use 
# in a existing task. As a special feature if protocol is already in use a copy is 
# ProtocolVersion is created so not to advisely effect a running task. 
# 
  def edit
    find_process
    @protocol_version = @study_protocol.editable
  end
  
##
# Edit the Process layout
# 
  def layout
    find_process
    @protocol_version = @study_protocol.editable
  end

##
# Show a preview
# 
  def preview
    find_process
    @data_sheet = TreeGrid.from_process(@protocol_version)
  end
  
##
# Create a DataEntry template based on the current definition
#
  def template
    find_process
    grid =TreeGrid.from_process(@protocol_version)
    send_data(grid.to_csv,:type => 'text/csv; charset=iso-8859-1; header=present',
                          :filename => "#{@study_protocol.name}-v#{@protocol_version.version}.csv")
  rescue Exception => ex
      logger.error ex.message
      logger.error ex.backtrace.join("\n")
      flash[:error] = ex.message
      flash[:trace] = ex.backtrace.join("<br \>")
      render :action => 'list',:id =>@study   
  end
    
###
# Update Study to use new protocol. This saves the used defined label for the process instance
# and the allocated stage of the protocol.
#
  def update
    find_process    
    if @study_protocol.update_attributes(params[:study_protocol])
      if params[:version]                       
        @protocol_version = ProtocolVersion.find(params[:version])  
        if @protocol_version.update_attributes(params[:protocol_version])
           flash[:info] = "Updated overview for protocol [#{@study_protocol.name}] "
        else
           logger.warn flash[:warning] = "Failed to update current protocol version [#{@study_protocol.name}] "
        end
      end
      
    else
      logger.warn flash[:warning] = "Failed to update protocol [#{@study_protocol.name}] "
    end
    
    respond_to do | format |
       format.html { render :action => 'show'}
       format.xml  { render :xml =>  @protocol_version.to_xml(:include=>[:protocol])}
       format.js   { render :update do | page |
           page.replace_html "process_overview", :partial => 'process_overview'
           page.replace_html "messages", :partial => 'shared/messages', :locals => { :objects => ['study_protocol','process_version'] }
         end 
       }
    end
  end

###
# Destory a protocol totally
#
  def destroy
    @study_protocol = StudyProtocol.find(params[:id])
    @study = @study_protocol.study
    @study_protocol.destroy
    redirect_to :action => 'list', :id => @study
  end


##
# update the a parameter context. This will update the label, default row and extra details
# for all the parameters. Parametters are passed via params[:cell] and the context is passed
# via params[:parameter_context]
# 
  def update_context
   ProtocolVersion.transaction do
      text = request.raw_post || request.query_string
      @parameter_context = ParameterContext.find(params[:id])         
      if  @parameter_context.update_attributes(params[:parameter_context]) 
        if params[:cell] and !params[:cell].empty?     
          for row in params[:cell]         
             @parameter = Parameter.find(row[0])
             @parameter.name =  row[1]['name']
             @parameter.default_value = row[1]['default_value']
             @parameter.mandatory = row[1]['mandatory']
             unless @parameter.save
               logger.error flash[:warning] = "#{flash[:warning]}\n Parameter [#{@parameter.name}] not updated in context [#{@parameter_context.path}] "
               break
             end
          end
        end
      else   
        flash[:warning] = "Failed to updated in context [#{@parameter_context.path}] "
      end
   end
   respond_to do | format |
       format.html { render :action => 'layout'}
       format.xml  { render :xml =>  @protocol_version.to_xml(:include=>[:protocol])}
       format.js   { render :update do | page |
          page.replace_html @parameter_context.dom_id, :partial => 'current_context', 
                    :locals => {:parameter_context => @parameter_context, :hidden => false }
          page.replace_html "messages", :partial => 'shared/messages', :locals => { :objects => ['protocol_version','parameter_context','parameter'] }
          page.visual_effect :SlideDown, @parameter_context.dom_id('detail')
         end 
       }
    end
 end

##
# Create a new basic process context
# 
  def add_context
   @successful  = false
   begin
      @parent = ParameterContext.find(params[:id])
      @protocol_version = @parent.process
      @parameter_context = @protocol_version.new_context
      @parameter_context.parent = @parent;
      @successful  = @parameter_context.save
      flash[:notice] = 'Context '+@parameter_context.label+"  was successfully added"
   rescue
      logger.warn $!.to_s
      flash[:error]= $!.to_s
   end
    redirect_to :action => 'layout', 
          :id => @parameter_context.process.protocol,
          :version=> @parameter_context.process 
  end


##
# This deletes a context and all its children
#
 def remove_context
    @successful = false
    @parameter_context = ParameterContext.find(params[:id])
    @process = @parameter_context.process
    if  @parameter_context.parent_id.nil? or @parameter_context.children.size>0
        flash[:error] = ' Cant delete a context row with children'   
    else
       @dom = @parameter_context.dom_id
       @successful = @parameter_context.destroy
       @process.resync_columns
       flash[:notice] = 'Context successfully removed '
    end
    return render( :action => 'delete_row.rjs') if request.xhr?  
    return_to_main
 end
  
##
# Add a new parameter to the current parameters for the instance this expects the id of parameter type, 
# instance and role to create the new record. parameter name is automatically generated
# based on the max(sequence_num) for parameters of type in the process, so you will get 
# dose,dose_1,dose_2 etc. 
#
 def add_parameter
   @successful  = false
   ProtocolVersion.transaction do
     @parameter_context = ParameterContext.find(params[:id]) 
     @protocol_version = @parameter_context.process
     style, id = params[:node].split("_")
     case style
       when 'sp' : @parameter = @parameter_context.add_parameter( StudyParameter.find(id) )
       when 'sq' : @parameter = @parameter_context.add_queue( StudyQueue.find(id) )
     end
     if @parameter
       @successful = @parameter.save
       @parameter.process.resync_columns
       @parameter_context.reload
     else
       flash[:error] = 'Parameter creation failed.'
     end
    end
    respond_to do | format |
      format.html { render :action => 'layout',:id => @parameter_context.process.protocol,:version=> @parameter_context.process }
      format.xml  { render :xml => @parameter_context.to_xml }
      format.js   { render :update do | page |
          if @successful
            page.replace_html @parameter_context.dom_id, :partial => 'current_context', 
                              :locals => {:parameter_context => @parameter_context, :hidden => false }
            page.replace_html "messages", :partial => 'shared/messages', :locals => { :objects => ['protocol_version','parameter_context','parameter'] }
          else
            page.replace_html "messages", :partial => 'shared/messages', :locals => { :objects => ['parameter_context','parameter'] }
          end
         end }
    end
 end
   
##
# Change the Role of a parameter in the protocol. Afraid with drag and drop
# its easy to drop things in the wrong place so a simple recovery is needed. 
#
def move_parameter
  ProtocolVersion.transaction do
    @parameter = Parameter.find(params[:id])
    @after = Parameter.find(params[:after])
    @parameter_context = @after.context 
    @protocol_version = @parameter_context.process
    @source = @parameter.context 
    if @source != @parameter_context
       @parameter.context = @parameter_context
       @successful = @parameter.save
       flash[:notice] = "#Parameter #{@parameter.name} moved from #{@source.label} to context #{@parameter_context.label}"
    else   
       @parameter.after(@after)
       @parameter_context.reload
       @successful = true
       logger.info "reorder #{@parameter_context.parameters.collect{|i|i.name}.join(',')}"
    end 
  end 
    respond_to do | format |
      format.html { render :action => 'layout',:id => @parameter_context.process.protocol,:version=> @parameter_context.process }
      format.xml  { render :xml => @parameter_context.to_xml }
      format.js   { render :update do | page |
          if @successful
            page.replace_html @parameter_context.dom_id, :partial => 'current_context', 
                              :locals => {:parameter_context => @parameter_context, :hidden => false }
            page.replace_html "messages", :partial => 'shared/messages', :locals => { :objects => ['protocol_version','parameter_context','parameter'] }
          else
            page.replace_html "messages", :partial => 'shared/messages', :locals => { :objects => ['parameter_context','parameter'] }
          end
         end }
    end
end

##
# Remove a parameter from the process context. In the drag and drop the id is sp_nnn in known its 
# a simple nnnn. 
#  
def remove_parameter
   @successful = false
   begin
      id = params[:id].split("_")[1]
      id = params[:id] unless id
      logger.info "remove parameter "+id
      parameter = Parameter.find(id)
      @parameter_context = parameter.context     
      @successful = parameter.destroy
      @parameter_context.process.resync_columns
      flash[:notice] = 'Parameter successfully removed '
   rescue
      logger.warn "problem with create "+$!.to_s
      flash[:error]  = $!.to_s
   end
   return render( :action => 'update_row.rjs') if request.xhr?  
   return_to_main
end  
 
##
#Export a protocool as a XML file
#  
 def export
    if params[:id]
    @study_protocol = StudyProtocol.find(params[:id])
    xml = Builder::XmlMarkup.new(:ident=>2)
    xml.instruct!
    @study_protocol.to_xml(xml)
    send_data(xml.target!(),
      :type => 'text/xml; charset=iso-8859-1; header=present',
      :filename => @study_protocol.name+'.xml')     
    end  
 end

#
# get a set of context tables
#
 def table
   @parameter_context = ParameterContext.find(params[:id])
   render :partial => 'table'
 end
 #
 # Get a table of data for a context definition
 #
 def context
   @parameter_context = ParameterContext.find(params[:id])
   render :partial => 'context'
 end  
##
#Import a protocol into the systems. This reads the xml generated above.
#  
#  @todo Items need to work on protocol transfer between systems
#  
  def import
  end

protected  

  def find_process
    @study_protocol = current_user.protocol(params[:id])
    @study =@study_protocol.study
    @project_folder = @study_protocol.folder 
    @protocol_version = ProtocolVersion.find(params[:version]) if params[:version]
    @protocol_version ||= @study_protocol.process
    @folder = set_folder(@study_protocol.folder)
  end 
  
end
