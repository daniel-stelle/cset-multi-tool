module TimesheetsHelper
  
  # Role enums
  TECH      = 0
  CHK_OUT   = 1
  TA_GRADER = 2
  
  # Functions
  
  # Gives the proper header text depending
  # on the role that the timesheet is for.
  def role_header_text
    case @role
      when TECH
        "Your Lab Technician Timesheets"
      when CHK_OUT
        "Your Equipment Checkout Timesheets"
      when TA_GRADER
        "Your Lab TA/Grader Timesheets"
    end
  end
end
