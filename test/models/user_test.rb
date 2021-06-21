require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end 
  
  test "should be valid" do
    assert @user.valid?
  end
  
    test "name should be present" do
    @user.name = "      "
    assert_not @user.valid? #@userが有効でなくなったことを確認（@userが無効なら成功、有効なら失敗）
  end
  
    test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
   test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.   
                           foo@bar_baz.com foo@bar+baz.com]                     #配列で５つのアドレス指定
    invalid_addresses.each do |invalid_address|                                 #それぞれの要素をブロックinvalid_addressに繰り返し代入。1つずつ検証。
      @user.email = invalid_address                                             #@user.emailにブロックを代入
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"   #@userが有効なら失敗、無効なら成功。第二引数で失敗したメールアドレスをそのまま文字列として表示
    end
  end
  
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save                                                                  #@userをデータベースに保存
    assert_not duplicate_user.valid?                                            #複製したduplicate_userが有効なら失敗、無効なら成功
  end
end
