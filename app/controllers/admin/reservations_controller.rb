class Admin::ReservationsController < ApplicationController
  def index
    # showing_movies = Movie.where(is_showing: true)
    # schedules = showing_movies.preload(:schedules)
    # @reservations = schedules.preload(:reservations)
    @all_reservations = Reservation.all
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def new
    @reservation = Reservation.new
  end

  def create
    if reservation_params[:schedule_id].nil? ||
       reservation_params[:date].nil?
       flash[:danger] = "エラーが発生しました"
      redirect_to request.referer
    else    
      reservation = Reservation.new(reservation_params)
      if reservation.save
        flash[:success] = "予約が完了しました"
        redirect_to admin_reservations_path
      else
        flash[:danger] = "その座席はすでに予約済みです"
        render :new, status: 400
      end
    end
  end

  def update
    reservation = Reservation.find(params[:id])
    if reservation.update(reservation_params)
      flash[:success] = "変更が完了しました"
      redirect_to admin_reservations_path
    else
      flash.now[:danger] = "変更に失敗しました"
      render :show
    end
  end

  def destroy
    reservation = Reservation.find(params[:id])
    if reservation.destroy
      flash[:success] = "削除が完了しました"
      redirect_to admin_reservations_path
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:date, :name, :email, :schedule_id, :sheet_id)
  end

end
