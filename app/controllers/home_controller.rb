include ApplicationHelper

class HomeController < ApplicationController
  before_filter :print_params
  before_filter :load_today
  after_filter :format_flash
  after_filter :print_today_hash
  
  def index
    @projects = ordered_projects(Project.all.sort_by{|l| l[:title]})
  end
  
  private
    def print_params
      puts params
    end

    def print_today_hash
      puts "\n\nToday hash: " + session[:today].to_s
    end

    def load_today
      date_today = Time.zone.today.iso8601
      # Create session variables if they don't already exist
      session[:today] = {:date => date_today} if !session.has_key?("today")
      session[:today] = {:date => date_today} if session[:today][:date] != date_today
      session[:today][:projects] = [] if !session[:today].has_key?("projects")
    end

    def today_add_project(project_id)
      session[:today][:projects].push(project_id)
    end
end
