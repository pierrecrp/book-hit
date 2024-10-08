class BookingsController < ApplicationController
  before_action :set_offer, only: [:create, :new]

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.offer = @offer
    @booking.user = current_user
    if @booking.save
      redirect_to dashboards_path
    else
      render "offers/show", status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update(accepted: params[:accepted])
    flash[:notice] = 'Booking was successfully updated.'
    redirect_to dashboards_path
    #render :edit, status: :unprocessable_entity

  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to order_path(@booking.list), status: :see_other
  end

  private

  def booking_params
    params.require(:booking).permit(:target, :deadline, :accepted, :target_address, :user_id, :offer_id)
  end

  def set_offer
    @offer = Offer.find(params[:offer_id])
  end
end
