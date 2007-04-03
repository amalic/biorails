# This manages the creation of Roles
#
# @TODO needs to be be rewritten now goldberg is removed

class Admin::RolesController < ApplicationController
  check_permissions << 'index' << 'update' << 'create' << 'destroy' << 'list'

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def index
    list
    render :action => 'list'
  end

  def list
    @roles = Role.find(:all,:order => 'name')
  end

  def show
    @role = Role.find(params[:id])
  end

  def new
    @role = Role.new
    foreign()
  end

  def create
    @role = Role.new(params[:role])
    if @role.save
      Role.rebuild_cache
      flash[:notice] = 'Role was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @role = Role.find(params[:id])

  end

  def update
    @role = Role.find(params[:id])
    logger.info params[:allowed].to_yaml
    if @role.update_attributes(params[:role])
      @role.reset_rights(params[:allowed])
      @role = Role.find(params[:id])
      flash[:notice] = 'Role was successfully updated.'
      redirect_to :action => 'show', :id => @role.id
    else
      render :action => 'edit'
    end
  end

  def destroy
    Role.find(params[:id]).destroy
    redirect_to :action => 'list'
  end


    
end
