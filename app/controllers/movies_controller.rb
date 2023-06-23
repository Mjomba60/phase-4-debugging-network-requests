class MoviesController < ApplicationController
  rescue_from  ActiveRecord::RecordNotFound, with: :record_not_found_response
  
  wrap_parameters format: []
  
  def index
    movies = Movie.all
    render json: movies
  end

  def create
    render json: Movie.create(movie_params), status: :created
  end

  def update
    movie = find_movie
    movie.update(movie_params)
    render json: movie, status: :accepted
  end

  def destroy
    movie = find_movie
    movie.destroy
    head :no_content
  end


  private

  def movie_params
    params.permit(:title, :year, :length, :director, :description, :poster_url, :category, :discount, :female_director)
  end

  def find_movie
    Movie.find(id: params[:id])
  end

  def record_not_found_response
    render json: {error: "Movie not found"}, status:  :not_found
  end

end
