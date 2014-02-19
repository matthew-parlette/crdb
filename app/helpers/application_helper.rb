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
  
  #take a list of projects and organize them by:
  # active, inactive, closed
  def ordered_projects(project_list)
     projects = {:active => nil, :inactive => nil, :closed => nil}
     
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
