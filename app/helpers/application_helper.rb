module ApplicationHelper
  def format_url(url)
    url.start_with?('http://') ? url : 'http://' + url 
  end
end
