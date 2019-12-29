class TalksController < ApplicationController

  before_action :logged_in_user, only: [:create, :destroy]
  #before_action :correct_user, only: :destroy

  def create
    @weibo = Weibo.find(talk_params[:weibo_id])
    @talk = @weibo.talks.build(talk_params)
    @talk.user_id = current_user.id
    if @talk.save!
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def show
    @talk = Talk.find(params[:id])
    @weibos = Weibo.find(params[:@talk.weibo_id])
  end

  def talking
    @weibos = []
    @title = '我的评论'
    @user = current_user
    talks = Talk.where(user_id: @user.id)
    weibo_ids = talks.map { |talk| talk.weibo_id }.uniq.compact
    weibo_ids.each do |w|
      @weibos << Weibo.includes(:talks,:user).where(id: w).first
    end
    render 'show_talking'
  end

  def talked
    talks = []
    @title = '评论我的'
    @user = current_user
    weibos = Weibo.where(user_id: @user.id)
    weibos.each do |wb|
      talks = Talk.where(weibo_id: wb.id)
    end
    weibo_ids = talks.map { |talk| talk.weibo_id }.uniq.compact
    @weibos = Weibo.includes(:talks,:user).where(id: weibo_ids)
    render 'show_talked'
  end

  def destroy
    @talk=Talk.find params[:id]
    @talk.destroy
    flash[:success] = "成功删除评论"
    redirect_to request.referrer || root_url
  end

  private

  def talk_params
    params.require(:talk).permit(:weibo_id, :content)
  end

  #def correct_user
  #  @talk = current_user.weibo.talks.find_by(id: params[:id])
  #  redirect_to root_url if @talk.nil?
  #end
end
