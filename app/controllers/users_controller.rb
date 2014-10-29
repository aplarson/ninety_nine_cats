class UsersController < ApplicationController
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
    @user = User.new(user_params)
    if @user.save
      login_user!
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
  

end
