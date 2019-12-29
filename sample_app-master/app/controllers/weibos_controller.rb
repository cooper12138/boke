class WeibosController < ApplicationController

  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @weibo = current_user.weibos.build(weibo_params)
    #@weibo = WeibosService.new(weibo_params).issaved
    if @weibo.save
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end


  def destroy
    @weibo.destroy
    flash[:success] = "成功删除微博"
    redirect_to request.referrer || root_url
  end

  private

  def weibo_params
    params.require(:weibo).permit(:content)
  end

  def correct_user
    @weibo = current_user.weibos.find_by(id: params[:id])
    redirect_to root_url if @weibo.nil?
  end
end
