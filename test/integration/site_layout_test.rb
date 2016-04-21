require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # Test that links that should exist, do exist on the root path (home page)
  test 'layout links' do
    get root_path
    assert_template 'sessions/new'
    # Make sure there are 2 home buttons on page
    assert_select 'a[href=?]', root_path
    # Make sure help button exists on page
    assert_select 'a[href=?]', help_path
    # Make sure about button exists on page
    assert_select 'a[href=?]', about_path
  end
end
