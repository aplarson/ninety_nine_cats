class CatsController < ApplicationController
  before_action only: [:edit, :update] do |controller|
    @cat = Cat.find(params[:id])
    unless current_user && @cat.user_id == current_user.id
      redirect_to cats_url
    end
  end
  
  def index
    @cats = Cat.all
    render :index
  end
  
  def show
    @cat = Cat.find(params[:id])
    render :show
  end
  
  def new
    @cat = Cat.new
    render :new
  end
  
  def create
    @cat = Cat.new(cat_params)
    if current_user
      @cat.user_id = current_user.id
    end
    
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end
  
  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end
  
  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end
  
  private
    def cat_params
      params.require(:cat)
            .permit([:name, :birth_date, :sex, :description, :color])
    end
end
