module ApplicationHelper
  def status_options
    options = ['new',
               'in progress',
               'waiting on customer',
               'on hold',
               'cancelled',
               'delivered',
               'complete'
              ]
    return options
  end
  
  #returns a bootstrap contextual color based on the status
  def status_color(status)
     if status == "new"
          return "danger"
     elsif status == "in progress"
          return "warning"
     elsif status == "waiting on customer"
          return "info"
     elsif status == "on hold"
          return "primary"
     elsif status == "cancelled"
          return "default"
     elsif status == "delivered"
          return "info"
     elsif status == "complete"
          return "success"
     else
          return "default"
     end
  end
  
  #take a list of projects and organize them by:
  # active, inactive, closed
  def ordered_projects(project_list)
     projects = {:active => [], :inactive => [], :closed => []}
     
     project_list.each do |project|
          if project.status.in?(['waiting on customer','on hold','delivered'])
               projects[:inactive].push(project)
          elsif project.status.in?(['cancelled','complete'])
               projects[:closed].push(project)
          else
               projects[:active].push(project)
          end
     end
     
     return projects
  end
end
