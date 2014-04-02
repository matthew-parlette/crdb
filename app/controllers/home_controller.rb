include ApplicationHelper

class HomeController < ApplicationController
  before_filter :print_params
  before_filter :load_today
  after_filter :format_flash
  #after_filter :update_notifications
  after_filter :print_today_hash
  
  def index
    @projects = ordered_projects(Project.all.sort_by{|l| l[:title]})
  end

  def today
    if params.has_key?("today")
      if params[:today].has_key?("projects")
        if params[:today][:projects].has_key?("action") and params[:today][:projects].has_key?("id")
          today_add_project(params[:today][:projects][:id]) if params[:today][:projects][:action] == "add"
          today_remove_project(params[:today][:projects][:id]) if params[:today][:projects][:action] == "remove"
        end
      end
    end

    update_notifications

    respond_to do |format|
      format.json { render json: session[:today] }
    end
  end
  
  private
    def print_params
      puts params
    end

    def print_today_hash(pretext = nil)
      puts pretext
      puts "Today hash: " + session[:today].to_s
    end

    def load_today
      #uncomment the next line to reset today's session for testing
      #session[:today] = nil
      date_today = Time.zone.today.iso8601
      
      # Create session variables if they don't already exist, or is too old
      if !session[:today] or !session.key?(:today) or session[:today][:date] != date_today
        session[:today] = {
                           :date => date_today,
                           :projects => Set.new(),
                           :notifications => Hash.new(),
                           :badges => Hash.new(),
                          }
      end

      # Set some variables based on the today hash
      @working_projects = Set.new()
      session[:today][:projects].each do |id|
        @working_projects.add(Project.find(id))
      end
      puts "@working_projects set is: " + @working_projects.first.to_s

    end

    def update_notifications
    # all notifications off unless something enables them
    session[:today][:notifications][:planning] = nil
    session[:today][:notifications][:working] = nil

      if session[:today][:projects].count > 0
        session[:today][:notifications][:planning] = nil
        session[:today][:badges][:working] = session[:today][:projects].count
      else
        session[:today][:notifications][:planning] = "error"
      end
    end

    def today_add_project(project_id)
      puts "Adding #{project_id} to today's projects..."
      puts "#{project_id} already exists..." if session[:today][:projects].include?(project_id)
      session[:today][:projects].add(project_id)
    end

    def today_remove_project(project_id)
      puts "Removing #{project_id} to today's projects..."
      session[:today][:projects].delete(project_id)
    end
end
