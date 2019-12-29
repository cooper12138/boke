class Relationship < ApplicationRecord

  #　微博关注人和被关注人建立关系中间表
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'
end
