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
  
  private
  
    def timesheet_row_params
      params.require(:timesheet_row).permit(:date_worked, :time_in, :time_out)
    end
end