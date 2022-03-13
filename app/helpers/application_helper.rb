module ApplicationHelper
  def timer(start_time)
    Time.at(start_time / 1000).strftime('%M:%S')
  end
end