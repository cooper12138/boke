module UsersHelper
  #返回指定用户的Gravatar头像
  def gravatar_for(user, options = { size: 80 })
    size = options[:size]
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    #gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    gravatar_url = 'https://dss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1912113785,1587702892&fm=26&gp=0.jpg'
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
