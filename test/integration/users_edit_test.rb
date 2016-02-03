require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:daniel)
  end
  
  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { name: "",
                                    email: "foo@invalid",
                                    password: "foo",
                                    password_confirmation: "bar" }
    assert_template 'users/edit'
  end
  
  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    firstName = "Foo"
    lastName = "Bar"
    email = "foo.bar@oit.edu"
    patch user_path(@user), user: { firstName: firstName,
                                     lastName: lastName,
                                     email: email,
                                     password: "",
                                     password_confirmation: "" }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal firstName, @user.firstName
    assert_equal lastName, @user.lastName
    assert_equal email, @user.email
  end
  
  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    firstName  = "Foo"
    lastName = "Bar"
    email = "foo.bar@oit.edu"
    patch user_path(@user), user: { firstName:  firstName,
                                    lastName: lastName,
                                    email: email,
                                    password:              "",
                                    password_confirmation: "" }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal firstName,  @user.firstName
    assert_equal lastName, @user.lastName
    assert_equal email, @user.email
  end
end
