include ApplicationHelper

class ProjectsController < ApplicationController
  before_filter :print_params
  before_filter :find_customer
  after_filter :format_flash

  def index
    if params.has_key?(:customer_id)
      @projects = Project.where(:customer_id => params[:customer_id]).sort_by{|l| l[:title]}
    else
      @projects = Project.all.sort_by{|l| l[:title]}
    end
    @projects = ordered_projects(@projects)
    respond_to do |format|
      format.html {}
      format.json { render json: @projects }
    end
  end
  
  def show
    find_project
    respond_to do |format|
      format.html {}
      format.json { render json: @project }
    end
  end
  
  def new
    @project = Project.new
    @project.status = 'new'
    if params.has_key?(:customer_id)
      @project.customer_id = params[:customer_id]
    end
  end
  
  def create
    @project = Project.new(filtered_params)
    
    respond_to do |format|
      if @project.save
        flash[:notice] = "Project '#{@project.title}' was successfully created for '#{@customer}'."
        format.html { redirect_to @project }
        format.json { render json: @project, status: :created }
      else
        format.html { render 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
    find_project
  end
  
  def update
    find_project
    
    respond_to do |format|
      if @project.update(filtered_params)
        flash[:notice] = "Project '#{@project.title}' was successfully updated."
        format.json { render json: @project }
        
        if session.has_key?("back")
          format.html { redirect_to session[:back] }
        else
          format.html { render 'show' }
        end
      else
        @alert = ["Project '#{@project.title}' could not be updated."]
        @errors = @project.errors
        format.html { render 'edit' }
        format.json { render json: @project.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    find_project
    project_title = @project.title
    
    respond_to do |format|
      if @project.destroy
        flash[:notice] = "Successfully deleted '#{project_title}' for '#{@customer}'."
        format.html { redirect_to(projects_path) }
        format.js   {}
        format.json { render json: @project, status: :deleted }
      else
        @alert = ["Project '#{project_title}' could not be deleted."]
        @errors = @project.errors
        format.html { render json: @project.errors, status: :unprocessable_entity }
        format.js   {}
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def status
    find_project
    session[:back] = :back
  end
  
  private
    def print_params
      print params
    end
    
    def find_customer
      if @project and @project.customer_id
        @customer = Customer.find(@project.customer_id)
      end
    end
    
    def filtered_params
      params.require(:project).permit(:title,:description,:links,:customer_id,:status,
                                      :completed,:start_date,:due_date,
                                      :completed_date)
    end
    
    def find_project
      @project = Project.find(params[:id])
    end
end
