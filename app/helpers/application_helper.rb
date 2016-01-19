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
end
