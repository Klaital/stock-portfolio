require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(slug: "example-user", email: "user@example.com")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "slug should be present" do
    @user.slug = "   "
    assert_not @user.valid?
  end

  test "slug should not be too long" do
    @user.slug = "a" * 51
    assert_not @user.valid?
  end

  test "slug validation should accept valid slugs" do
    valid_slugs = %w[user12 user-12 user_3 user.4 USER-five 123456]
    valid_slugs.each do |valid_slug|
      @user.slug = valid_slug
      assert @user.valid?, "#{valid_slug} should be a valid slug"
    end
  end

  test "slug validation should reject invalid slugs" do
    invalid_slugs = [ 'user@1', 'ユーザー', ' ', '' ]
    invalid_slugs.each do |invalid_slug|
      @user.slug = invalid_slug
      assert_not @user.valid?, "'#{invalid_slug}' should be an invalid slug"
    end
  end

  test "slug should be unique" do
    duplicate_user = @user.dup
    duplicate_user.slug = @user.slug.upcase
    @user.save
    duplicate_user.email = @user.email + 'a' # The email address has to be different as well
    assert_not duplicate_user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.slug = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be a valid email"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be an invalid email"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

end
