
class Weibo < ApplicationRecord

  has_many :talks, class_name: 'Talk',dependent: :destroy

  belongs_to :user

  # 倒叙排序微博
  default_scope -> {order(created_at:  :desc)}

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

end
