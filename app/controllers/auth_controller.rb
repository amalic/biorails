# == Description
# Login/Out controller this manage the presentation of a login page to the 
# user.
#
# == Copyright
# 
# Copyright � 2006 Robert Shell, Alces Ltd All Rights Reserved
# See license agreement for additional rights ##
#
class AuthController < ApplicationController


# GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)

  def index
    login
  end
  
  def login
    if request.get?
      render :action=>'login',:layout=> 'simple'
    else
      user = User.authenticate(params[:login],params[:password])
      if user and user.enabled?  
        user.clear_login_failures      
        set_user(user)
        set_project(Project.load(UserSetting.default_project_id))
        logger.info "User #{params[:login]} successfully login"
        redirect_to( session[:last_url] || home_url(:action=>'show') )
      else
        logger.info "User #{params[:login]} login failed"
        User.register_login_failure(params[:login])
        clear_session
        login_failed 
      end
    end    
  rescue Exception=> ex
    logger.debug ex.backtrace.join("\n")
    logger.error ex.message
    clear_session
    login_failed 
  end  # def login

  def logout
    logger.info "logout #{session[:user_id]}"
    clear_session
    render :action=>'login',:layout=> 'simple'
  end

protected  

  def login_failed
    flash.now[:error] = "Incorrect Name/Password"
    render :action => 'forgotten',:layout=> 'simple'
  end

end
