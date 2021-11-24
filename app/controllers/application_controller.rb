class ApplicationController < ActionController::Base

  # include UserHelper

  # 只要所有 controller 發生這個錯誤，都會捕捉到這個錯誤，然後找 404 頁面渲染出來
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # 讓 view 可以使用
  helper_method :user_signed_in?, :current_user

  private
  def record_not_found
    render file: 'public/404.html', layout: false, status: 404
  end

  def user_signed_in?
    # session 是否存在?
    session[:hahow].present?
  end

  def current_user
    # 找到目前的 user，登入後會回傳一個物件回來，如 <User:0x00007fffeba5d780>
    # 在同一個畫面或 action，如果有人多次呼叫@current_user，就不會再抓一次目前的 user，像 cache的概念
    # memorization
    @current_user ||= User.find_by(id: session[:hahow])
  end

end
