require 'test_helper'

class AddStudentTest < ActionDispatch::IntegrationTest
  
  # Makes sure that user is returned to Add Student Page
  # if invalid information was entered
  test "invalid student information" do
    get add_student_path
    assert_no_difference 'User.count' do
      post users_path, user: {firstName: "",
                              lastName: "",
                              email: "user@invalid",
                              password: "foo",
                              password_confirmation: "bar" }
    end
    assert_template 'users/new'
  end
  
  test "valid student information" do
    get add_student_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { firstName: "Example",
                                            lastName: "User",
                                            email: "example.user@oit.edu",
                                            password: "password",
                                            password_confirmation: "password" }
    end
    assert_template 'users/show'
  end
end
