class Api::V1::CoursesController < ApplicationController

  # 站內不要使用，站外不得以才能使用
  # skip_before_action :verify_authenticity_token
  before_action :check_login

  #還沒寫，確認課程是你喜歡的，或不喜歡的
  def like
    course = Course.find(params[:id])

    favorited_course = FavorCourse.find_by(user: current_user, course: course)
    if favorited_course
      favorited_course.destroy
      render json: { result: 'unlike' }
    else
      current_user.favorite_courses << course
      render json: { result: 'like' }
    end
  end

  private
  def check_login
    # early return
    if not user_signed_in?
      render json: {status: 'fail', message: 'you need to login first'}, status: 401
      return #記得結束，不然會出現 double render
    end
  end
end
