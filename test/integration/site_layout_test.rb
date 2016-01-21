require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  # Test that links that should exist, do exist on the root path (home page)
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2  # Make sure there are 2 home buttons on page
    assert_select "a[href=?]", help_path            # Make sure help button exists on page
    assert_select "a[href=?]", about_path           # Make sure about button exists on page
  end
end
