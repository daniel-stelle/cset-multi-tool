class RelationshipsController < ApplicationController
  def new
    @users = User.students
    @relationship = Relationship.new #(supervisor: current_user)
  end
  
  def create
    #@relation = current_user.relationship.build(worker_id: params[:relationship][:id])
    @relation = Relationship.new(relationship_params.merge(supervisor: current_user))
    @relation.worker_id = params[:relationship][:id]
    
    if @relation.save
      flash[:success] = 'Worker successfully added'
      redirect_to current_user
    else
      flash[:danger] = 'Student is already a worker of yours'
      redirect_to new_relationship_path
    end
  end
  
  def index
    @workers = current_user.workers
  end
  
  def destroy
    if Relationship.find(params[:id]).destroy
      flash[:success] = 'Worker successfully removed from your list.'
    else
      flash[:danger] = 'Unable to remove worker from your list.'
    end
    
    redirect_to relationships_path
  end
  
  private
  
    def relationship_params
      params.require(:relationship).permit(:worker_id)
    end
end
