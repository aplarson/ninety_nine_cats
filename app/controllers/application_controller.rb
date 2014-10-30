class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def current_user
    @session = Session.find_by_session_token(session[:session_token])
    if @session
      @session.user
    end
  end
  
  def current_session
    Session.find_by_session_token(session[:session_token])
  end
  
  helper_method :current_user
  helper_method :current_session
  
  def login_user!(user_id)
    @session = Session.new
    #request is instance method of controller
    environment = request.env["HTTP_USER_AGENT"]
    location = request.location.city
    @session.novel_session(user_id, environment, location)
    session[:session_token] = @session.session_token
    
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
end
