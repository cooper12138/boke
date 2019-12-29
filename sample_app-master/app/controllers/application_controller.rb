#
# = bne jikzq
#
class ApplicationController < ActionController::Base
  include SessionsHelper #引入Sessions辅助模块

  protect_from_forgery with: :exception

  def hello
    render html: "hello world!"
  end

  private

  #
  # == 确保用户已登录
  #
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "请先登录！"
      redirect_to login_url
    end
  end
end
