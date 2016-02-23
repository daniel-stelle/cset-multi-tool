module ApplicationHelper
  
  # Changes the title of the page depending on if a title
  # was given or not
  def full_title(page_title = '')               # Optional parameter
    base_title = "CSET Multi-tool Application"  # Base title of the page
    
    # If no title was given, just show the base title
    if page_title.empty?
      base_title
    else # Else display the title given with the base title concatenated
      page_title + " | " + base_title
    end
  end
  
  # Show the time in Hour:Min AM/PM format
  def show_time(time)
    time.strftime("%I:%M %p")
  end
  
  def show_date(date)
    date.strftime("%m-%d-%Y")
  end
  
  # Calculates the total hours worked to 2 decimal places
  def calc_hours(time_in, time_out)
    number_with_precision(((time_out - time_in).to_f / 60) / 60, precision: 2)
  end
  
  # Checks to see if the timesheet is clocked out or not
  def clocked_out?(ts_row)
    ts_row.time_out?
  end
  
  # Determines the home page to go to depending on log in status
  def home_page 
    logged_in? ? current_user : root_path
  end
end
