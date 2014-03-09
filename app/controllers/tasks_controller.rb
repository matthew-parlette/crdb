include ApplicationHelper

class TasksController < ApplicationController
  before_filter :print_params
  before_filter :save_previous_page, :only => [:create, :update, :destroy]
  after_filter :format_flash
  
  def show
  end

  def index
    if params.has_key?(:project_id)
      @tasks = Task.where(:project_id => params[:project_id])
    else
      @tasks = Task.all
    end
  end

  def new
    @task = Task.new
    if params.has_key?(:project_id)
      @task.project_id = params[:project_id]
    end
  end

  def create
    @task = Task.new(filtered_params)
    
    respond_to do |format|
      if @task.save
        flash[:notice] = 'Task was successfully created.'
        format.html { redirect_to session[:back] }
        format.json { render json: @task, status: :created }
      else
        format.html { render 'new' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    find_task
    
    respond_to do |format|
      if @task.update(filtered_params)
        format.json { render json: @task }
      else
        @alert = ["'#{@task.title}' could not be updated."]
        @errors = @task.errors
        format.json { render json: @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    find_task
    task_title = @task.title
    
    respond_to do |format|
      if @task.destroy
        flash[:notice] = "Deleted task '#{task_title}'."
        format.html { redirect_to(session[:back]) }
        format.js   {}
        format.json { render json: @task, status: :deleted }
      else
        @alert = ["'#{@task.title}' could not be deleted."]
        @errors = @task.errors
        format.html { render json: @task.errors, status: :unprocessable_entity }
        format.js   {}
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    def print_params
      print params
    end
    
    def save_previous_page
      session[:back] = :back
    end
    
    def filtered_params
      params.require(:task).permit(:title,:project_id,:completed)
    end
    
    def find_task
      @task = Task.find(params[:id])
    end
end
