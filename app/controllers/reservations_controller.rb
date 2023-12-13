class ReservationsController < ApplicationController
  def new
    @movie = Movie.find_by(params[:movie_id])
    @schedule = Schedule.find_by(params[:schedule_id])
    if params[:sheet_id].nil? || params[:date].nil?
      flash[:danger] = "エラーが発生しました"
      redirect_to movies_path
    else
      @sheet = Sheet.find(params[:sheet_id])
      @date = params[:date]
      @reservation = Reservation.new
    end
  end

  def create
    if reservation_params[:schedule_id].nil? ||
       reservation_params[:date].nil?
       flash[:danger] = "エラーが発生しました"
      redirect_to request.referer
    else    
      reservation = Reservation.new(reservation_params)
      schedule = Schedule.find(reservation_params[:schedule_id])
      movie = Movie.find(schedule.movie_id)
      if reservation.save
        flash[:success] = "予約が完了しました"
        redirect_to reservation_path(movie_id: movie.id, schedule_id: schedule.id, date: reservation_params[:date])
      else
        flash[:danger] = "その座席はすでに予約済みです"
        redirect_to reservation_path(movie_id: movie.id, schedule_id: schedule.id, date: reservation_params[:date])
      end
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:date, :name, :email, :schedule_id, :sheet_id)
  end

end
