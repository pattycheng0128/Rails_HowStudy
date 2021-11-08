class UsersController < ApplicationController

  def sign_up
  end

  def account_verify
    puts "======================"
    puts params
    puts "======================"

    redirect_to "/"
  end

end