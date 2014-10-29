class CatRentalRequestsController < ApplicationController
  before_action only: [:approve, :deny] do |controller|
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat = Cat.find(@cat_rental_request.cat_id)
    unless current_user && @cat.user_id == current_user.id
      redirect_to cats_url
    end
  end
  
  def create
    @cat_rental_request = CatRentalRequest.new(rental_params)
    if current_user
      @cat_rental_request.requester_id = current_user.id
    end
    
    if @cat_rental_request.save
      redirect_to cat_url(@cat_rental_request.cat_id)
    else
      flash.now[:errors] = @cat_rental_request.errors.full_messages
      render :new
    end
  end
  
  def destroy
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_rental_request.destroy
    redirect_to cats_url
  end
  
  def new
    @cat_rental_request = CatRentalRequest.new
    render :new
  end
  
  def approve
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_rental_request.approve!
    redirect_to cat_url(@cat_rental_request.cat_id)
  end
  
  def deny
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_rental_request.deny!
    redirect_to cat_url(@cat_rental_request.cat_id)
  end
  
  private
    def rental_params
      params.require(:cat_rental_request)
            .permit([:start_date, :end_date, :cat_id])
    end
end