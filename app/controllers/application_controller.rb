class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    return nil if self.session[:session_token].nil?
    @user ||= User.find_by(session_token: self.session[:session_token])
  end


  def login!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def ensure_logged_in
    redirect_to new_session_url unless current_user
  end

  def logout!(user)
    session[:session_token] = nil
    user.reset_session_token!
  end

  def is_authorized?(id)
    current_user.id == id
  end



end
