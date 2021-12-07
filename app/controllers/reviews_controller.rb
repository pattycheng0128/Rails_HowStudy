class ReviewsController < ApplicationController
  before_action :authenticate!

  def create
    #先找到這門課程，才能做留言
    course = Course.find(params[:course_id])
    # 將評論的內容丟給 review
    @review = course.reviews.build(clean_review_params)
    # review.user_id = current_user.id //id被省略了
    # 將目前的 user 丟給評論的 user
    #review.user = current_user #這行可以用 merge 方式加在 clean_review_params

    if @review.save
      # course 是第六行 find
      redirect_to course_path(course), notice: "完成評價"
      #簡寫: redirect_to course, notice: "完成評價" 
      #註解後會跑 create.js.erb
    else
      render html: params
    end
  end

  private
  def clean_review_params
    # 沒加 merge，評論只會有一條，有加 merge，在做 create 時，就會確認目前 user
    params.require(:review)
    .permit(:rating, :title, :content)
    .merge(user: current_user)
  end

end
