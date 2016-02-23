module UsersHelper
  
  def user_full_name(user)
    if user
      user.firstName.capitalize + " " + user.lastName.capitalize
    end
  end
end
