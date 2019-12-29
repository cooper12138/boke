
class StaticPagesController < ApplicationController

  def home
    return unless logged_in?
    @weibo = current_user.weibos.build
    @talk =  @weibo.talks.build
    @feed_items = current_user.feed.paginate(page: params[:page])
  end

  def help
  end

  def about
  end

  def contact
  end

end
