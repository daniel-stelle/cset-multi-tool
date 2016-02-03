require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:daniel)
  end
  
  test "login with invalid information" do
    get login_path                                        # Go to log in page
    assert_template 'sessions/new'                        # Make sure log in page is loaded
    post login_path, session: { email: "", password: "" } # Enter invalid log in information
    assert_template 'sessions/new'                        # Make sure log in page is loaded again
    assert_not flash.empty?                               # Make sure a flash message was displayed
    get root_path                                         # Go to home page (just visiting another page)
    assert flash.empty?                                   # Make sure the flash message did not persist
  end
  
  test "login with valid information followed by logout" do
    get login_path
    post login_path, session: { email: @user.email, password: 'password' }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    delete logout_path # Simulate a user clicking logout in a second window.
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
  
  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end
  
  test "login without remembering" do
    log_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end
end
