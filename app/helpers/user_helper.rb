module UserHelper
  def user_signed_in?
    # session 是否存在?
    session[:hahow].present?
  end

  def current_user
    # 找到目前的 user
    User.find(session[:hahow])
  end

end