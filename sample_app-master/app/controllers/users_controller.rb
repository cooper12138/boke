class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "成功删除用户"
    redirect_to users_url
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @weibos = @user.weibos.includes(:talks).paginate(page: params[:page])

    #@usered = Talk.where(weibo_id:@weibos.id)
  end

  def create
    @user = User.new( user_params )
    if @user.save
      #处理注册成功的情况
      #自动登录
      log_in @user
      # 闪现消息
      flash[:success] = '欢迎使用Sample App!'
      #重定向到用户页面
      redirect_to @user #user_url(@user)
    else
      render 'new'
    end
  end

  def update
    @user = User.find( params[:id] )
    if @user.update(user_params)
      #处理更新成功的情况
      flash[:success] = "更新成功"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def edit
    @user = User.find( params[:id] )
  end

  def following
    @title = '我的关注'
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = '我的粉丝'
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  #确保是正确的用户
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  #确保是管理员
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end
