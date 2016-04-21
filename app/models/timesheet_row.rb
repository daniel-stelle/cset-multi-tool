class TimesheetRow < ActiveRecord::Base
  belongs_to :timesheet

  # Min out getter, setter
  def min_out
    @min_out ||= time_out.min
  end

  def min_out=(val)
    @min_out = val
  end

  # Hour out getter, setter
  def hour_out
    @hour_out ||= time_out.hour
  end

  def hour_out=(val)
    @hour_out = val
  end

  # Min in getter, setter
  def min_in
    @min_in ||= time_in.min
  end

  def min_in=(val)
    @min_in = val
  end

  # Hour in getter, setter
  def hour_in
    @hour_in ||= time_in.hour
  end

  def hour_in=(val)
    @hour_in = val
  end

  private

    # Before_update actions

    # Sets the new times
    def set_new_time
      @dt_in = time_in.to_datetime
      update_column(:time_in, @dt_in.change(hour: hour_in.to_i, min: min_in.to_i))
      
      @dt_out = time_out.to_datetime
      update_column(:time_out, @dt_out.change(hour: hour_out.to_i, min: min_out.to_i))
    end
end
