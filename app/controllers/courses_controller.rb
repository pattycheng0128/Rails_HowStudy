class CoursesController < ApplicationController

  def index
  end

  def new
    @course = Course.new
  end

  def create
    # render html: params
    # redirect_to "/courses"
    # redirect_to courses_path
    @course = Course.new(clean_params)

    if @course.save
      redirect_to courses_path
    else
      render :new
    end
  end

  # def edit
  # end

  def show
  end

  def edit
  end

  def destroy
  end

  private
  def clean_params
    params.require(:course).permit(:name, :price, :intro, :hour)
  end
  
end
