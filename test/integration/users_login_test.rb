require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:daniel)
  end

  test 'login with invalid information' do
    # Go to log in page
    get root_path
    # Make sure log in page is loaded
    assert_template 'sessions/new'
    # Enter invalid log in information
    post login_path, session: { email: '', password: '' }
    # Make sure log in page is loaded again
    assert_template 'sessions/new'
    # Make sure a flash message was displayed
    assert_not flash.empty?
    # Go to home page (just visiting another page)
    get root_path
    # Make sure the flash message did not persist
    assert flash.empty?
  end

  test 'login with valid information followed by logout' do
    get root_path
    post login_path, session: { email: @user.email, password: 'password' }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select 'a[href=?]', root_path, count: 0
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    delete logout_path # Simulate a user clicking logout in a second window.
    follow_redirect!
    assert_select 'a[href=?]', root_path
    assert_select 'a[href=?]', logout_path,      count: 0
    assert_select 'a[href=?]', user_path(@user), count: 0
  end

  test 'login with remembering' do
    log_in_as(@user, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end

  test 'login without remembering' do
    log_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end
end
