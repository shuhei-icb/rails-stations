class MoviesController < ApplicationController
  def index
    @all_movies = Movie.all

    keyword = Movie.search(params[:keyword])
  
    if params[:is_showing] == "1"
      @all_movies = keyword.where(is_showing: true)
    elsif params[:is_showing] == "0"
      @all_movies = keyword.where(is_showing: false)
    else
      @all_movies = keyword
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @schedules = @movie.schedules
  end

  def reservation
    @movie = Movie.find(params[:movie_id])
    if params[:schedule_id].nil? || params[:date].nil?
      flash[:danger] = "エラーが発生しました"
      redirect_to movie_path(@movie.id) 
    else
      @sheets = Sheet.all 
      reservations = Reservation.eager_load(:schedule).where(schedules: {id: params[:schedule_id]})
      @sheet_ary = []
      reservations.each do |r|
        @sheet_ary << r.sheet_id
      end
    
      @schedule_id = params[:schedule_id]
      @date = params[:date]
    end
  end

end
