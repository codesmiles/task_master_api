class Api::V1::Auth::TaskController < ApplicationController
 
skip_before_action :authenticate_request, only: [:index]
  def index
    @tasks = Task.all

    render json: @tasks, status: :ok
  end
  def user_tasks
    @user_id = current_user.id
    @tasks = Task.where(user_id: user_id)
    render json: tasks, status: :ok
    
  end

  def create_user_task
    @task = Task.new(task_params)
    @task.user_id = current_user.id

    if @task.save
      render json: @task, status: :created
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show_single_task
    @task = Task.find_by(id: params[:id], user_id: current_user.id)
    render json: @task, status: :ok
  end

  def update_task(task_params)
    # find task by task_id and user id
    @task = Task.find_by(id: params[:id], user_id: current_user.id)
     
    if !@task.present?
      render json: { message: 'Not found' }, status: :not_found  # 404 Not Found status code for not found resource 
    end
    
    if @task.update(task_params)
      render json: @task, status: :ok
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
    
  end

  def destroy_task
    @task = Task.find_by(id: params[:id], user_id: current_user.id)
    
    if !@task.present?
      render json: { message: 'Not found' }, status: :not_found
    end
      
    @task.destroy
    render json: { message: 'Task deleted successfully' }, status: :no_content


    
  end

  private

  def task_params
    params.permit(:title, :description, :due_date, :priority)
  end
end
