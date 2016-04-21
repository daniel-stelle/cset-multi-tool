class RolesController < ApplicationController

  def new
    @role = Role.new
  end
  
  def create
    @role = Role.new(role_params)
    
    if(@role.save)
      flash[:success] = 'it worked'
    else
      flash[:danger] = 'role not created'
    end
  end
  
  private
  
    def role_params
      params.require(:role).permit(:tech, :ta_grader, :supervisor, :checkout)
    end
end
