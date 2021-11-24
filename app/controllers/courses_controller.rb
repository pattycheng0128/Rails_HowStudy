class CoursesController < ApplicationController

  # 除了 index 和 show 不需要確認登入的動作  
  before_action :find_course, only: [:show, :edit, :update, :destroy]
  #除了index和show頁面外，其它頁面登入都要確認
  before_action :login?, except: [:index, :show]

  def index
    @courses = Course.all #撈出所有資料
  end

  def new
    @course = Course.new
  end

  def create
    # @course = Course.new(clean_params)
    # 注意 application_controller 要 include user_helper module，這樣所有繼承至 application 就都可以用

    # 看 sqlite courses 資料表會多一個 user_id 欄位，會建立關聯
    # @course.user_id = current_user.id #使用者要登入後才允許資料進來
    # 目前的使用者會有很多課程
    @course = current_user.courses.build(clean_params) #抵上面兩行

    if @course.save
      redirect_to courses_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    # 更新課程資訊
    if @course.present?
      @course.update(clean_params)
      # flash[:notice] = "已經更新成功" #早期的寫法
      redirect_to '/courses', notice: "已經更新成功" #後期的寫法
    else
      render :edit
    end
  end

  def destroy
    # 刪除
    # find_course()
    if @course.present?
      @course.destroy
    end
    redirect_to '/courses', notice:"課程已經被刪除!"
  end

  private
  def find_course
    # 把課程資料撈出來
    # @course = Course.find_by(id:params[:id])
    # begin rescue 還沒加
    #課程的使用者才能進去編輯
    @course = current_user.courses.find(params[:id])

  end

  # 問題: permit會允許所有資料進來
  def clean_params
    params.require(:course).permit(:name, :price, :intro, :hour)
  end

  # 如果沒登入，轉去登入頁面 - 使用者要先登入，才能新增課程
  def login?
    # 用 session 寫法也 OK
    if not user_signed_in?
      redirect_to sign_in_path, notice:'請先登入頁面'
    end
  end
end
