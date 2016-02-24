class TimesheetRow < ActiveRecord::Base
  belongs_to :timesheet
  # validates :hour_in,  inclusion: 0..24
  # validates :hour_out, inclusion: 0..24
  # validates :min_in,   inclusion: 0..59
  # validates :min_out,  inclusion: 0..59
  
  before_update :set_new_time
  
  # Min out getter, setter
  def min_out
    @min_out ||= self.time_out.min
  end
  
  def min_out=(val)
    @min_out = val
  end
  
  # Hour out getter, setter
  def hour_out
    @hour_out ||= self.time_out.hour
  end
  
  def hour_out=(val)
    @hour_out = val
  end
  
  # Min in getter, setter
  def min_in
    @min_in ||= self.time_in.min
  end
  
  def min_in=(val)
    @min_in = val
  end
  
  # Hour in getter, setter
  def hour_in
    @hour_in ||= self.time_in.hour
  end
  
  def hour_in=(val)
    @hour_in = val
  end
  
  private
  
    # Before_update actions
    
    # Sets the new times 
    def set_new_time
      @dt_in = self.time_in.to_datetime
      self.update_column(:time_in, @dt_in.change(hour: hour_in.to_i, min: min_in.to_i))
      
      @dt_out = self.time_out.to_datetime
      self.update_column(:time_out, @dt_out.change(hour: hour_out.to_i, min: min_out.to_i))
    end
  
end
