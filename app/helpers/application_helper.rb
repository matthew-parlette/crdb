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
end
