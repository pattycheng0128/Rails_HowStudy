module UserHelper
  def user_signed_in?
    # session 是否存在?
    session[:hahow].present?
  end
end