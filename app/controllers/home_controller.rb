include ApplicationHelper

class HomeController < ApplicationController
  before_filter :print_params
  before_filter :load_today
  after_filter :format_flash
  
  def index
    @projects = ordered_projects(Project.all.sort_by{|l| l[:title]})
  end
  
  private
    def print_params
      print params
    end

    def load_today
      # Create session variables if they don't already exist
      session[:today] = {} if !session.has_key?("today")
      session[:today][:projects] = [] if !session[:today].has_key?("projects")
    end

    def today_add_project(project_id)
      session[:today][:projects].push(project_id)
    end
end
