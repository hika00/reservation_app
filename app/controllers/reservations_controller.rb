class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @room = Room.find(params[:room_id])
    @reservation = Reservation.new
  end

  def create
    @room = Room.find(params[:room_id])
    @reservation = @room.reservations.new(reservation_params)
    @reservation.user = current_user

    if @reservation.save
      redirect_to reservations_path, notice: "施設の予約が完了しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:checkin_at, :checkout_at, :guest_count)
  end
end
