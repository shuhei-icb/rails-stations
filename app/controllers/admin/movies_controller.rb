class Admin::MoviesController < ApplicationController
  def index
    @all_movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      flash[:success] = "登録が完了しました"
      redirect_to admin_movies_path
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      flash[:success] = "変更が完了しました"
      redirect_to admin_movies_path
    else
      flash.now[:danger] = "変更に失敗しました"
      render :edit
    end
  end

  def destroy
    movie = Movie.find(params[:id])
    if movie.destroy
      flash[:success] = "削除が完了しました"
      redirect_to admin_movies_path
    end
  end

  def movie_params
    params.require(:movie).permit(:name, :year, :description, :image_url, :is_showing)
  end

end
