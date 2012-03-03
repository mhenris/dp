# This controller handles the login/logout function of the site.
class SessionController < ApplicationController

  # render new.rhtml
  def new
    @login = cookies[:login_email]
  end

  def create
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        self.current_user.remember_me
        cookies[:auth_token]  = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
        cookies[:login_email] = { :value => params[:login], :expires => 4.weeks.from_now }
      end

      unless current_user.contact.nil?
        update_last_seen
        redirect_back_or_default home_url(@org)
        flash[:notice] = "Logged in successfully"
      end
    elsif @user = User.find_by_login_and_password(params[:login], params[:password]) and not @user.activated?
      flash.now[:notice] = "You haven't yet activated your account. Please follow the instructions in the activation email that was sent to you. (<a href='#{resend_activation_org_user_path(@org, @user, :token => @user.resend_activation_token)}'>Click here to request a new activation email</a>.)"
      render :action => :new
    else
      flash.now[:notice] = "Login or Password is incorrect. Please try again."
      render :action => :new
    end
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_to root_path
  end

  private
  def update_last_seen
    if current_user != :false
      current_user.contact.update_attributes! :last_seen => DateTime.now.utc
    end
  end

end
