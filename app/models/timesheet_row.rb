class TimesheetRow < ActiveRecord::Base
  belongs_to :timesheet
  
  #before_save   :check_clocked_out # Before clocking in
  #before_update :check_clocked_in  # Before clocking out
  
  private
  
    def check_clocked_out
      #clocked_out?(self)
      !self.time_out?
    end
    
    def check_clocked_in
      #clocked_in?(self)
      self.time_out.nil?
    end
end
