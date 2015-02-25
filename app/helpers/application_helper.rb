module ApplicationHelper
  def format_url(url)
    url.start_with?('http://') ? url : 'http://' + url 
  end
  
  def format_time(dt)
    logged_in? ? dt = dt.in_time_zone(current_user.time_zone) : dt
  end
end
