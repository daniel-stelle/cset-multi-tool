class TimesheetsController < ApplicationController
  def show
    @timesheet = Timesheet.find(params[:id])
    @ts_rows = @timesheet.timesheet_rows
  end

  def create
    @timesheet = current_user.timesheets.build
    @timesheet.role_id = params[:role_id]

    if @timesheet.save
      flash[:success] = 'Timesheet saved'
    else
      flash[:danger] = 'Timesheet not created'
    end

    redirect_to user_timesheets_path(current_user, role_id: params[:role_id])
  end

  def update
    @timesheet = Timesheet.find(params[:id])

    if @timesheet.update_attributes(timesheet_params)
      flash[:success] = 'Saved Timesheet'
      redirect_to @timesheet
    end
  end

  def index
    # Check if logged in
    @role = params[:role_id].to_i
    @timesheets = current_user.timesheets.role(params[:role_id])
    # @timesheets = User.find(params[:user_id]).timesheets.role(params[:role_id])
  end

  def clock_in
    @ts = Timesheet.find(params[:id])
    @ts_rows = @ts.timesheet_rows

    # See about putting checks into model
    if !@ts_rows.any? || clocked_out?(@ts_rows.last)
      @ts.timesheet_rows.build(date_worked: Date.today, time_in: Time.now)
      @ts.save
    else
      flash[:danger] = 'You must clock out first.'
    end

    redirect_to timesheet_path(id: @ts.id, user_id: @ts.user_id)
  end

  def clock_out
    @ts = Timesheet.find(params[:id])
    @ts_rows = @ts.timesheet_rows

    # See about putting checks into model
    unless !@ts_rows.any? || clocked_out?(@ts_rows.last)
      @ts.timesheet_rows.last.update_attributes(time_out: Time.now)
    else
      flash[:danger] = 'You must clock in first.'
    end

    redirect_to timesheet_path(id: @ts.id, user_id: @ts.user_id)
  end

  private

    def timesheet_params
      params.require(:timesheet).permit(:role_id,
                                        timesheet_row_attributes: [:id, 
                                                                   :date_worked,
                                                                   :time_in,
                                                                   :time_out])
    end
end
