class CoursesController < ApplicationController

  # 除了 index 和 show 不需要確認登入的動作 
  # before_action :login?, except: [:index, :show] 

  def index
    @courses = Course.all #撈出所有資料
  end

  def new
    @course = Course.new
  end

  def create
    # @course = Course.new(clean_params)
    # 注意 application_controller 要 include user_helper module
    # 看 sqlite courses 資料表會多一個 user_id 欄位
    # @course.user_id = current_user.id
    @course = current_user.course.build(clean_params) # 抵上面兩行

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
      # flash[:notice] = "已經更新成功"
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
    redirect_to '/courses', notice:"課程已經被刪除!"
  end

  private
  def clean_params
    params.require(:course).permit(:name, :price, :intro, :hour)
  end

  def find_course
    # 把課程資料撈出來
    @course = Course.find_by(id:params[:id])
    # begin rescue 還沒加
    # @course = current_user.courses.find(params[:id])
  end

  def login?
    # 用 session 寫法也 OK
    if user_signed_in?
      redirect_to sign_in_path, notice:'請先登入頁面'
    end
  end
  
end
