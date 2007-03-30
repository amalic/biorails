class Admin::UsersController < Project::BaseController
  member_actions << 'show' << 'update'

  def index
    @users = User.find(:all)
  end
  
  def list 
    index
  end
  
  def new
    @user  = User.new
  end

  def create
    @user = User.new params[:user]
    @user.save!
    flash[:notice] = "User created."
    redirect_to :action => 'index'
  rescue ActiveRecord::RecordInvalid
    flash[:error] = "Save failed."
    render :action => 'new'
  end

  def update
    render :update do |page|
      if @user.update_attributes(params[:user])
        page.call 'Flash.notice', 'Profile updated.'
      else
        page.call 'Flash.errors', "Save failed: #{@user.errors.full_messages.to_sentence}"
      end
    end
  end

  def destroy
    @user.deleted_at = Time.now.utc
    @user.save!
  end

  def enable
    @user.deleted_at = nil
    @user.save!
  end
  
  def admin
    @membership = Membership.find_or_initialize_by_site_id_and_user_id(site.id, @user.id)
    @membership.admin = !@membership.admin?
    @membership.save!
  end
  
  protected

    
    def authorized?
      logged_in? && (admin? || (current_user.id.to_s == params[:id] && member_actions.include?(action_name)))
    end
end
