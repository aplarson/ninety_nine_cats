class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def current_user
    User.find_by_session_token(session[:session_token])
  end
  
  helper_method :current_user
  
  def login_user!
    @user.reset_session_token!
    session[:session_token] = @user.session_token
    redirect_to cats_url
  end
  
  def find_by_user_params
    User.find_by_credentials(
         params[:user][:user_name],
         params[:user][:password])
  end
  
  private
    def user_params
      params.require(:user).permit(:user_name, :password)
    end
    
    def redirect_logged_in_user
      fail
      redirect_to cats_url unless current_user.nil?
    end
end
