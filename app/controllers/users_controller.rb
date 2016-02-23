class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :correct_user,   only: [:show, :edit, :update]
  
  def show
    @user = current_user
    #@timesheet = Timesheet.find(params[:role_id])
  end
  
  def new
    @user = User.new
    @role = @user.build_role
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "Student successfully added."
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      render 'edit'
    end
  end
    
  private
    
    def user_params
      params.require(:user).permit(:firstName, :lastName, :email,
                                   :password, :password_confirmation,
                                   role_attributes: [:id, :tech, :ta_grader, :checkout, :user_id],
                                   timesheet_attributes: [:id, :role_id])
    end
    
    # Before filters
    
    # Confirms a logged-in user
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Stop trying to hack the site, asshole!"
        redirect_to login_url
      end
    end
    
    # Confirms the correct user
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
