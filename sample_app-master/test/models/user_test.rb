require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @User = User.new(name:'Exeample User',email:'994739211@qq.com')
  end

  test "should be vaild" do
    assert @user.vaild?
  end
end
