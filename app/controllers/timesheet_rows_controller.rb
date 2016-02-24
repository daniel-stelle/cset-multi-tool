class TimesheetRowsController < ApplicationController
  
  def show
    #@ts_rows = User.find(params[:user_id]).timesheets.role(params[:role_id]).timesheet_rows
  end
  
  def new
    #@timesheet_rows = TimesheetRow.new
  end

  def create
    #@timesheet_rows = TimesheetRow.new(timesheet_row_params)
  end
  
  def edit
    @row = TimesheetRow.find(params[:id])
  end
  
  def update
    @row = TimesheetRow.find(params[:id])
    
    if @row.update_attributes(timesheet_row_params)
      flash[:success] = "Row updated"
    else
      flash[:danger] = "Row could not be updated"
    end
    
    redirect_to user_timesheet_path(current_user, @row.timesheet)
  end
  
  private
  
    def timesheet_row_params
      params.require(:timesheet_row).permit(:date_worked,:time_in, :time_out, :hour_in, :min_in, :hour_out, :min_out)
    end
end