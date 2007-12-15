##
# Copyright © 2006 Robert Shell, Alces Ltd All Rights Reserved
# See license agreement for additional rights

##
# This manages the list of Parameter Types in the system. It was added to provide
# the bases for parameterized data entry. Parameters have rules on the type of data
# they accept. The key one of theses is a allow vocabary
# 
# Actions supported:-
# * list         list all items
# * new/create   create a new item
# * edit/update  edit a exiting item
# * destroy      destroy item and all its dependent objects
# 
class Admin::ParameterTypesController < ApplicationController

  use_authorization :catalogue,
                    :actions => [:list,:show,:new,:create,:edit,:update,:destroy],
                    :rights => :current_user
 

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @parameter_types = ParameterType.paginate(:page => params[:page])
  end

  def show
    @parameter_type = ParameterType.find(params[:id])
  end

  def new
    @parameter_type = ParameterType.new
    @parameter_type.data_type_id = 2
    @parameter_type.storage_unit = ""
  end

  def create
    @parameter_type = ParameterType.new(params[:parameter_type])
    if @parameter_type.save
      flash[:notice] = 'ParameterType was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @parameter_type = ParameterType.find(params[:id])
  end

  def update
    @parameter_type = ParameterType.find(params[:id])
    if @parameter_type.update_attributes(params[:parameter_type])
      flash[:notice] = 'ParameterType was successfully updated.'
      redirect_to :action => 'show', :id => @parameter_type
    else
      render :action => 'edit'
    end
  end

  def destroy
    ParameterType.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
