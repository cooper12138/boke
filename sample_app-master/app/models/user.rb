class User < ApplicationRecord
  # 哈希算法加密密码存入数据库
  has_secure_password

  has_many :weibos, dependent: :destroy

  # 关注人和被关注人建立关联
  has_many :active_relationships, class_name: "Relationship",
           foreign_key: 'follower_id',
           dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship',
           foreign_key: 'followed_id',
           dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships

  before_save { email.downcase! }

  # 存在性验证  限制长度
  validates :name, presence: true, length: {maximum: 50}

  # 使用指定的正则表达式（regular expression，简称 regex）验证属性。
  # 常量 首字母大写
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email, presence: true, length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}

  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  # 返回指定字符串的哈希摘要
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
               BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # 返回用户的动态流
  def feed
    #Weibo.where('user_id IN (?) OR user_id = ?', follower_ids, id)
    following_ids = 'SELECT followed_id FROM relationships
                    WHERE follower_id = :user_id'
    Weibo.where("user_id IN ( #{following_ids}) OR user_id = :user_id", user_id: id)
  end

  #关注另一个用户
  def follow(other_user)
    following << other_user
  end

  #取消关注另一个用户
  def unfollow(other_user)
    following.delete(other_user)
  end

  #如果当前用户关注了指定的用户，返回true
  def following?(other_user)
    following.include?(other_user)
  end


  private
end
