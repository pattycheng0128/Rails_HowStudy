class CoursesController < ApplicationController

  # 除了 index 和 show 不需要確認登入的動作  
  before_action :find_course, only: [:show, :edit, :update, :destroy]
  #除了index和show頁面外，其它頁面登入都要確認
  before_action :authenticate!, except: [:index, :show]

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
    # 如果不是目前的 user ，create 一定會失敗，因為上面 before_action :authenticate!會確認如果不是使用者會被踢到登入頁面
    @course = current_user.courses.build(clean_params) #抵上面兩行

    if @course.save
      redirect_to courses_path
    else
      render :new
    end
  end

  def show
    # 找到課程，給 view 的 course_reviews_path 使用
    @course = Course.find(params[:id])
    # render html: params
    # 新增 review 實體
    @review = Review.new()
    #代替 where，每個課程都有很多 reviews, lazy loading 不會印出來，沒用到不會印出來
    # 用 Review.all 會撈到所有課程的使用者，應該要針對某個課程撈留言的資料
    # @reviews = Review.where(course_id: @course.id)
    # 每一門課有很多 reviews
    @reviews = @course.reviews.order(id: :desc)
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

  def buy
    @course = Course.find(params[:id])
    @order = Order.new

    #刷卡
    gateway = Braintree::Gateway.new(
      environment: :sandbox,
      merchant_id: "snq96mkz2r2py4vm",
      public_key: "4d9c98wws2qnyxvt",
      private_key: "f6eb1b220f883e76c02f123c66050a80",
    )
    # 長出專屬的 token
    @client_token = gateway.client_token.generate

  end

  private
  def find_course
    # 把課程資料撈出來
    # @course = Course.find_by(id:params[:id])
    #課程的使用者才能進去編輯
    @course = current_user.courses.find(params[:id])

  end

  # 問題: permit會允許所有資料進來
  def clean_params
    params.require(:course).permit(:name, :price, :intro, :hour)
  end

end
