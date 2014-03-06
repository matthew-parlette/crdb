class TasksController < ApplicationController
  before_filter :print_params
  
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
        format.html { redirect_to @task }
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
  end

  def destroy
  end
  
  private
    def print_params
      print params
    end
    
    def filtered_params
      params.require(:task).permit(:title,:project_id,:completed)
    end
    
    def find_project
      @task = Task.find(params[:id])
    end
end
