class ProjectsController < ApplicationController
  def index
    @projects = Project.all
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
    if params.has_key?(:customer_id)
      @project.customer_id = params[:customer_id]
    end
  end
  
  def create
    @project = Project.new(filtered_params)
    
    respond_to do |format|
      if @project.save
        flash[:notice] = 'Project was successfully created.'
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
        flash[:notice] = 'Project was successfully updated.'
        if session.has_key?("back")
          format.html { redirect_to session[:back] }
        else
          format.html { render 'show' }
        end
      else
        flash[:alert] = 'Project could not be updated.'
        format.html { render 'edit' }
      end
    end
  end
  
  def destroy
    find_project
    
    respond_to do |format|
      if @project.destroy
        flash[:notice] = "Successfully deleted project."
        format.html { redirect_to(projects_path) }
        format.js   {}
        format.json { render json: @project, status: :deleted }
      else
        flash[:alert] = "Project could not be deleted."
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
    def filtered_params
      params.require(:project).permit(:title,:description,:customer_id,:status,
                                      :completed,:start_date,:due_date,
                                      :completed_date)
    end
    
    def find_project
      @project = Project.find(params[:id])
    end
end
