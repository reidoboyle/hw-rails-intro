class MoviesController < ApplicationController

    def show
      id = params[:id] # retrieve movie ID from URI route
      @movie = Movie.find(id) # look up movie by unique ID
      # will render app/views/movies/show.<extension> by default
    end
    
    def index
      @all_ratings = Movie.ratings
      @checks = Movie.checked
      @rel = false
      @tit = false
      
      if (!params.has_key?(:ratings)) and (!session.has_key?(:ratings))
        session[:ratings] = Movie.inital_ratings
      end
      
      if params[:sort_by] == "release_date"
        session[:sort_by] = "release_date"
      elsif params[:sort_by] == "title"
        session[:sort_by] = "title"
      end
      
      if params.has_key?(:ratings)
        session[:ratings] = params[:ratings]
      else
        flash.keep
        redirect_to movies_path(:ratings => session[:ratings])
      end
      
      @movies = Movie.order("#{session[:sort_by]}")
      @movies = @movies.with_ratings(session[:ratings].keys)
      @checks = Movie.update_check(@checks,session[:ratings].keys)
      
      if session[:sort_by] == "title"
        @tit = true
      end
      if session[:sort_by] == "release_date"
        @rel = true
      end
      
    end
    
    def new
      # default: render 'new' template
    end
  
    def create
      @movie = Movie.create!(movie_params)
      flash[:notice] = "#{@movie.title} was successfully created."
      redirect_to movies_path
    end
  
    def edit
      @movie = Movie.find params[:id]
    end
  
    def update
      @movie = Movie.find params[:id]
      @movie.update_attributes!(movie_params)
      flash[:notice] = "#{@movie.title} was successfully updated."
      redirect_to movie_path(@movie)
    end
  
    def destroy
      @movie = Movie.find(params[:id])
      @movie.destroy
      flash[:notice] = "Movie '#{@movie.title}' deleted."
      redirect_to movies_path
    end
  
    private
    # Making "internal" methods private is not required, but is a common practice.
    # This helps make clear which methods respond to requests, and which ones do not.
    def movie_params
      params.require(:movie).permit(:title, :rating, :description, :release_date)
    end
  end