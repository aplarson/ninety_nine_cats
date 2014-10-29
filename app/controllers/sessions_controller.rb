class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end
  
  def create
    if @user = User.find_by_credentials(
                      params[:user][:user_name], 
                      params[:user][:password]
                    )
      @user.reset_session_token!
      session[:session_token] = @user.session_token
      redirect_to cats_url
    else
      @user = User.new(user_params)
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  def destroy
    session[:session_token] = nil
    current_user.reset_session_token!
    redirect_to cats_url
  end
end
