class WeibosService < ActiveService::Base

  def initialize(weibo_params)
    @weibo_params = weibo_params
  end

  def issaved
    @weibo = current_user.weibo.build(@weibo_params)
  end

end
