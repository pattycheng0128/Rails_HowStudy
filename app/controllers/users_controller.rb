class UsersController < ApplicationController

  def sign_up
    @user = User.new
  end

  def account_verify
    # 終端機會印出 token 的資訊
    # puts params
    clean_params = params.require(:user).permit(:username, :password, :email)

    @user = User.new(clean_params)

    if @user.save
      redirect_to "/" #轉址到首頁
    else
      # 借 sing_up 的 view 來使用
      render :sign_up
    end
  end

end