include ApplicationHelper

class HomeController < ApplicationController
  before_filter :print_params
  after_filter :format_flash
  
  def index
    @projects = ordered_projects(Project.all.sort_by{|l| l[:title]})
  end
  
  private
    def print_params
      print params
    end
end
