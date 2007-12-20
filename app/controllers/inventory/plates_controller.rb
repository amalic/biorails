##
# Copyright © 2006 Robert Shell, Alces Ltd All Rights Reserved
# See license agreement for additional rights
##
#
class Inventory::PlatesController < ApplicationController

  use_authorization :inventory,
                    :actions => [:list,:show,:new,:create,:edit,:update,:destroy],
                    :rights =>  :current_user  
 

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @plates = Plate.paginate :order=>'name', :page => params[:page]
  end

  def show
    @plate = Plate.find(params[:id])
  end

  def new
    @plate = Plate.new
  end

  def create
    @plate = Plate.new(params[:plate])
    if @plate.save
      flash[:notice] = 'Plate was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @plate = Plate.find(params[:id])
  end

  def update
    @plate = Plate.find(params[:id])
    if @plate.update_attributes(params[:plate])
      flash[:notice] = 'Plate was successfully updated.'
      redirect_to :action => 'show', :id => @plate
    else
      render :action => 'edit'
    end
  end

  def destroy
    Plate.find(params[:id]).destroy
    redirect_to :action => 'list'
  end


end
