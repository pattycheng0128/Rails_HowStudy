class CoursesController < ApplicationController

  def index
    @courses = Course.all #撈出所有資料
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

  def show
    # 把課程內容撈出來
    find_course()
  end

  def edit
    # 把課程內容撈出來
    find_course()
  end

  def update
    # 更新課程資訊
    @status_update = Course.find(params[:id])
    if @status_update.present?
      @status_update.update(clean_params)
      redirect_to '/courses', notice: "已經更新成功"
    else
      render :edit
    end
  end

  def destroy
    # 刪除
    @status_update = Course.find(params[:id])
    if @status_update.present?
      @status_update.destroy
    end
    redirect_to '/courses'
    notice:"課程已經被刪除!"
  end

  private
  def clean_params
    params.require(:course).permit(:name, :price, :intro, :hour)
  end

  def find_course
    # 把課程資料撈出來
    @course = Course.find_by(id:params[:id])
  end
  
end
