class Talk < ApplicationRecord
  belongs_to :weibo

  validates :user_id, presence: true
  validates :weibo_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
