class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def current_user
    User.find_by_session_token(session[:session_token])
  end
  
  helper_method :current_user
  
  private
    def user_params
      params.require(:user).permit(:user_name, :password)
    end
end
