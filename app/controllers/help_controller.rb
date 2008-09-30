# == Description
# This manages general Help functions
#
# == Copyright
# 
# Copyright � 2006 Robert Shell, Alces Ltd All Rights Reserved
# See license agreement for additional rights ##
#
class HelpController < ApplicationController

  def index
    redirect_to SystemSetting.help_root #+ @current_controller
  end
  
##
# This is a simple call to visualize the model the report is based on with all its related models
# as a simple graph.
# 
# params[:id] name of the report
# params[:levels] defaults to 2 how has down the graph to go
# params[:many] defaults to 1 how has to follow has_many relationships down
# params[:style] how to space dot and draw items 
# 
# options for style :-
#  * dot  draws  directed  graphs. 
#  * neato draws undirected graphs using ‘‘spring’’ models (see Kamada and Kawai, Information  Processing  Letters  31:1,  April  1989).
#  * twopi draws graphs using a radial layout (see G. Wills, Symposium on Graph Drawing GD’97, September, 1997). 
#  * circo  draws  graphs using a circular layout (see Six and Tollis, GD ’99 and ALENEX ’99, and Kaufmann and Wiese, GD ’02.) 
#  * fdp draws undirected graphs using a ‘‘spring’’ model. It relies on a force-directed approach in the spirit of Fruchterman and Rein‐gold (cf. Software-Practice & Experience 21(11), 1991, pp. 1129-1164).
# 
#  
  def report
    @report = Report.find(params[:id])
    @options= {}
    @options[:model]= params[:model]||@report.model
    @options[:levels]= params[:levels]||2
    @options[:many]= params[:many]||1
    @options[:style]= params[:style]||'dot'
    @options[:disposition]= params[:disposition]||'inline'
    @options[:type] = 'image/png'
    @options[:filename] = "model_#{@report.model.to_s.tableize}.png"
    @image_file = Biorails::UmlModel.create_model_diagram(File.join(RAILS_ROOT, "public/images"),@report.model,params)
    
    logger.info @image_file
    logger.info "**************************"
    
    send_file(@image_file.to_s,@options) 
  end 
  
##
# Create a uml model for a class
#      
  def uml
    @models = Biorails::UmlModel.models
    @options= {}
    @options[:model]= params[:model]||'Task'
    @options[:levels]= params[:levels]||2
    @options[:many]= params[:many]||1
    @options[:style]= params[:style]||'dot'
  end

###
# Simple diagram any model
# 
# @todo rjs close security hole on eval of command line 
# 
  def diagram
    
    model = eval(params[:id]||params[:model]||'Task')
    @models = Biorails::UmlModel.models
    @image_file =  Biorails::UmlModel.create_model_diagram(File.join(RAILS_ROOT, "public/images"),model,params)
    logger.info('************')
    logger.info(@image_file)
  
    send_file(@image_file.to_s,:disposition => 'inline',   :type => 'image/png') 
  end 

  
end
