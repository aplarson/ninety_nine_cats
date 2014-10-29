class SessionsController < ApplicationController
  before_action only: :new do |controller|
    if controller.current_user
      redirect_to cats_url
    end
  end
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    if @user = self.find_by_user_params
      login_user!
    else
      @user = User.new(user_params)
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to cats_url
  end
end
