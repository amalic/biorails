##
# Copyright © 2006 Robert Shell, Alces Ltd All Rights Reserved
# See license agreement for additional rights
##
#
class Study::StudyProtocolsController < ApplicationController

  helper SheetHelper
  
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
    @study = current( Study, params[:id] )
    @study_protocols = @study.protocols
  end

##
#Set the release protocol version
#
  def release
    @study_protocol = StudyProtocol.find(params[:id])
    @study_protocol.process = @study_protocol.lastest
    @study_protocol.save
    redirect_to :action => 'list', :id => @study_protocol.study
  end

##
# Show details for a protocol
# 
  def show
    @study_protocol = StudyProtocol.find(params[:id])
    @study = @study_protocol.study
    @process = @study_protocol.process
    @process = ProtocolVersion.find(params[:version]) if params[:version]
    logger.info @context_for_layout
  end

##
# Puts up the form for a new protocol, this created new Protocol, ProtocolVersion objects
# and open the edit form all all.
# 
  def new
    @study = Study.find(params[:id])
    @study_protocol = StudyProtocol.new(:study=>@study)
    @study_protocol.name = @study.name+"_"+(@study.protocols.size+1).to_s
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
    @study = Study.find(params[:id])   
    @study_protocol = StudyProtocol.new(params[:study_protocol])
    if @study_protocol.save
      @study_protocol.process = @study_protocol.new_version     
      @parameter_context = @study_protocol.process.new_context
      @study_protocol.process.save
      @study_protocol.save
      @parameter_context.save
      flash[:notice] = 'StudyProtocol was successfully created.'
      redirect_to :action => 'edit', :id => @study_protocol
      return    
    end
    render :action => 'new', :id => @study
  end

###
# Edit the protocol creating a new version of the instance if the protocol is in use 
# in a existing task. As a special feature if protocol is already in use a copy is 
# ProtocolVersion is created so not to advisely effect a running task. 
# 
  def edit
    @study_protocol = StudyProtocol.find(params[:id])
    @study = @study_protocol.study
    if params[:version]
      @protocol_version = ProtocolVersion.find(params[:version])
    else 
      @protocol_version = @study_protocol.editable
    end
    @data_sheet = TreeGrid.from_process(@protocol_version)
  end
  

###
# Update Study to use new protocol. This saves the used defined label for the process instance
# and the allocated stage of the protocol.
#
  def update
    @study_protocol = StudyProtocol.find(params[:id])
    if @successful = @study_protocol.update_attributes(params[:study_protocol])
      if params[:version]                       
        @protocol_version = ProtocolVersion.find(params[:version])  
        if @successful = @protocol_version.update_attributes(params[:protocol_version])
           @flash[:info] = "Updated overview for protocol [#{@study_protocol.name}] "
        else
           logger.warn @flash[:warning] = "Failed to update current protocol version [#{@study_protocol.name}] "
        end
      end
    else
      logger.warn @flash[:warning] = "Failed to update protocol [#{@study_protocol.name}] "
    end
    return render( :action => 'refresh_overview.rjs') if request.xhr?

    render :action => 'edit'

  rescue Exception => ex
    logger.error @flash[:error] =" Unexpected error in update for study_protocol #{params[:id]} exception: #{ex.message}" 
    logger.error ex.message
    logger.error ex.backtrace.join("\n")
    return render( :action => 'refresh_overview.rjs') if request.xhr?
    redirect_to :action => 'show', :id => @study_protocol
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
   @successful  = false
    text = request.raw_post || request.query_string
    @parameter_context = ParameterContext.find(params[:id])      
    @successful = @parameter_context.update_attributes(params[:parameter_context])
    if @successful and params[:cell] and  !params[:cell].empty?     
      for row in params[:cell]         
         @parameter = Parameter.find(row[0])
         @parameter.name =  row[1]['name']
         @parameter.default_value = row[1]['default_value']
         @parameter.mandatory = row[1]['mandatory']
         unless @parameter.save
           @flash[:warning] = "#{@flash[:warning]}\n Parameter [#{@parameter.name}] not updated in context [#{@parameter_context.path}] "
           logger.warn @flash[:warning]
           @successful  = false
           break
         end
      end
    else   
      @flash[:warning] = "Failed to updated in context [#{@parameter_context.path}] "
    end
    return render(:action => 'update_row.rjs') if request.xhr?
    return_to_main
 rescue Exception => ex
    @flash[:error] =" Unexpected error in update_context for #{params[:id]}" 
    logger.error  @flash[:error], ex.message, ex.backtrace.join("\n")
    @successful  = false    
    return render(:action => 'update_row.rjs') if request.xhr?
 end

##
# Create a new basic process context
# 
  def new_context
   @successful  = false
   begin
      @protocol_version = ProtocolVersion.find(params[:id])
      @parameter_context = @protocol_version.new_context
      @parameter_context.parent_id = params[:parent_id] if params[:parent_id]
      @successful  = @parameter_context.save
      flash[:notice] = 'Context '+@parameter_context.label+"  was successfully added"
   rescue
      logger.warn $!.to_s
      flash[:error]= $!.to_s
   end
   return render(:action => 'new_row.rjs') if request.xhr?
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
   begin 
     @parameter_context = ParameterContext.find(params[:context])
     style, id = params[:id].split("_")
     case style
       when 'sp' : @parameter = @parameter_context.add_parameter( StudyParameter.find(id) )
       when 'sq' : @parameter = @parameter_context.add_queue( StudyQueue.find(id) )
     end
     if @parameter
       @successful = @parameter.save
       @parameter.process.resync_columns
       flash[:notice] = 'Parameter '+@parameter.name+' added to Context '+@parameter_context.label+" successfully "
     else
        flash[:error] = 'Parameter creation failed.'
     end
  rescue
      logger.warn "problem with create "+$!.to_s
      flash[:error] = $!.to_s
  end
  return render( :action => 'update_row.rjs') if request.xhr?    
  return_to_main
 end
   
##
# Change the Role of a parameter in the protocol. Afraid with drag and drop
# its easy to drop things in the wrong place so a simple recovery is needed. 
#
def move_parameter
  @successful = false
  begin
    @parameter_context = ParameterContext.find(params[:context])
    @protocol_version = @parameter_context.process
    @parameter = Parameter.find(params[:id].split("_")[1])
    @source = @parameter.context 
    if @source != @parameter_context
       @parameter.context = @parameter_context
       @successful = @parameter.save
       flash[:notice] = "#Parameter #{@parameter.name} moved from #{@source.label} to context #{@parameter_context.label}"
    end 
  rescue
      logger.warn "problem with create "+$!.to_s
      flash[:error], @successful  = $!.to_s, false
  end
  return render( :action => 'move_row.rjs') if request.xhr?     
  return_to_main  
end

##
# This deletes a context and all its children
#
def delete_context
  @successful = false
  @parameter_context = ParameterContext.find(params[:id])
  @process = @parameter_context.process
  if @parameter_context.children.size>0
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


##
# Create a DataEntry template based on the current definition
#
  def template
    @study_protocol = StudyProtocol.find(params[:id])
    @study =@study_protocol.study
    if params[:version]
       @process = ProtocolVersion.find(params[:version])
    else
       @procsss = @study_protocol.process
    end 
    grid =TreeGrid.from_process(@process)
    expt = Experiment.new(:name=>'Preview',:study => @study_protocol.study,:protocol=>@study_protocol,:process=>@process)
    grid.task = Task.new(:name=>'<Process>',:experiment => expt,:protocol=>@study_protocol,:process=>@process)

    report = grid.export
    send_data(report.read,:type => 'text/csv; charset=iso-8859-1; header=present',
                          :filename => "#{@study_protocol.name}-v#{@process.version}.csv")
  rescue Exception => ex
      logger.error ex.message
      logger.error ex.backtrace.join("\n")
      flash[:error] = ex.message
      flash[:trace] = ex.backtrace.join("<br \>")
      render :action => 'list',:id =>@study   
  end
  
  
##
#Import a protocol into the systems. This reads the xml generated above.
#  
#  @todo Items need to work on protocol transfer between systems
#  
 def import
 end
  
end