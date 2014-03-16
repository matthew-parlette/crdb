module ApplicationHelper
  def status_options
    options = ['new',
               'in progress',
               'waiting on customer',
               'on hold',
               'cancelled',
               'delivered',
               'complete',
               'accepted'
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
    elsif status == "accepted"
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
      if project.status.in?(['waiting on customer','on hold','delivered','complete'])
        projects[:inactive].push(project)
      elsif project.status.in?(['cancelled','accepted'])
        projects[:closed].push(project)
      else
        projects[:active].push(project)
      end
    end
     
    return projects
  end
  
  #if the @notice or @alert arrays are set, move them into the
  # flash hash, separating each element with line breaks.
  # if @errors are defined, those will be added
  def format_flash
    if @alert
      if @errors
        @alert.push("<ul>")
        @alert.concat(@errors.to_a())
        @alert.push("</ul>")
      end
      flash[:alert] = @alert.join("<br>").html_safe
    end
    flash[:notice] = @notice.join("<br>").html_safe if @notice
  end

  #determine the priority for the given object
  # returns a hash with the priority and reasons for this priority
  def dynamic_priority(object)
    # initialize the return value
    result = { priority: 0, description: [] }
    return result if object == nil

    # project priority
    if object.status
      if object.status != "accepted"
        if object.due_date
          if object.due_date < Time.zone.today + 3.days
            result[:priority] += 1
            result[:description].push "due date is approaching"
          end
          if object.due_date < Time.zone.today
            result[:priority] += 1
            result[:description].push "due date has passed"
          end
        end
      end
    end

    if object.customer_id
      customer = Customer.find(object.customer_id)
      if customer.importance
        result[:priority] += customer.importance
        result[:description].push "customer importance is #{customer.importance}"
      end
    end
    return result
  end
end
