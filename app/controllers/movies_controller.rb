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
end
