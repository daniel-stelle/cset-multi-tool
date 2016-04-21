class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :correct_user,   only: [:show, :edit, :update]
  
  def show
    @user = current_user
  end
  
  def new
    @user = User.new
    @role = @user.build_role
    @user.supervisor_id = params[:supervisor_id]
  end
  
  # def index
  #   @users = User.students
  #   @worker = current_user.workers.build
  # end
  
  def create
    @user = User.new(user_params)
  
    if @user.save
      #establishes the supervisor/worker relationship record
      current_user.add_worker(@user) if @user.supervisor_id
      flash[:success] = 'Student successfully added.'
      redirect_to users_path
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated.'
      redirect_to @user
    else
      flash[:danger] = 'Unable to update profile.'
      render 'edit'
    end
  end
  
  # def show_workers
  #   @workers = current_user.workers
  # end
    
  private
    
    def user_params
      if (current_user && current_user.root?)
        params.require(:user).permit(:password, :password_confirmation)
      else
        params.require(:user).permit(:firstName, :lastName, :email,
                                     :password, :password_confirmation,
                                     :worker_id, :supervisor_id,
                                     role_attributes: [:id, :tech, :ta_grader,
                                                       :checkout, :user_id],
                                     timesheet_attributes: [:id, :role_id])
      end
    end
    
    # Before filters
    
    # Confirms a logged-in user
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = 'Please log in first.'
        redirect_to root_url
      end
    end
    
    # Confirms the correct user
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
