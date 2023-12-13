class Admin::SchedulesController < ApplicationController
  def index
    # @movies = Movie.preload(:schedules)
    @schedules = Schedule.all
  end

  def show
    @schedule = Schedule.find(params[:id])
  end

  def new
    @movie = Movie.find(params[:movie_id])
    @schedule = Schedule.new
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @schedule = @movie.schedules.new(schedule_params)
    if @schedule.save
      flash[:success] = "登録が完了しました"
      redirect_to admin_movie_path(@movie.id)
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update(schedule_params)
      flash[:success] = "変更が完了しました"
      redirect_to admin_movie_path(@schedule.movie.id)
    else
      flash.now[:danger] = "変更に失敗しました"
      render :edit
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    if @schedule.destroy
      flash[:success] = "削除が完了しました"
      redirect_to admin_movie_path(@schedule.movie.id)
    end
  end


  private

  def schedule_params
    params.require(:schedule).permit(:start_time, :end_time, :movie_id)
  end

end
