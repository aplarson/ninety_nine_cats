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
    if @user = find_by_user_params
      login_user!(@user.id)
    else
      @user = User.new(user_params)
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  def destroy
    @session = Session.find(params[:id])
    @session.destroy!
    redirect_to cats_url
  end
end
