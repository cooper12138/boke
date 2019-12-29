class SessionsController < ApplicationController

  def new
  end

  def create
    # 调service
    #user = User.find_by(email: params[:email].downcase)
    #user =  SessionsService.new(params[:email]).find_user
    user = SessionsService.find_user1(params[:email])
    if user&.authenticate(params[:password])
      #登入用户，然后重定向到用户的资料页面
      log_in user
      redirect_back_or user
    else
      flash.now[:danger] = '邮箱或密码错误'
      #创建一个错误信息
      render 'new'
    end

  end

  def destroy
    log_out
    redirect_to root_url
  end
end

