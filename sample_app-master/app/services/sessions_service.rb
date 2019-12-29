class SessionsService < ActiveService::Base

  attr_reader :email

  def initialize(email)
    @email = email
  end

  #实例方法
  def find_user
    User.find_by(email: email.downcase)
  end

  class << self
    #类方法
    def find_user1(email)
      User.find_by(email: email.downcase)
    end

  end

end
