module Api
  module V1
    module Auth
      class TasksController < ApplicationController
      # before_action :authenticate_request!
      skip_before_action :authenticate_request, only: [:all]
      before_action :set_task, only: [:show, :update, :destroy]

      def all
        @tasks = Task.all

        render json: @tasks, status: :ok
      end
      
      def index
        @tasks = current_user.tasks
        
        # Filtering
        @tasks = filter_tasks(@tasks)
        
        # Pagination
        @tasks = @tasks.page(params[:page]).per(params[:per_page] || 10)
        
        render json: @tasks, 
                each_serializer: TaskSerializer, 
                meta: pagination_meta(@tasks)
      end

      def show
        render json: @task, serializer: TaskSerializer
      end

      def create
        @task = current_user.tasks.build(task_params)

        if @task.save
          render json: @task, 
                  serializer: TaskSerializer, 
                  status: :created
        else
          render_error(@task)
        end
      end

      def update
        if @task.update(task_params)
          render json: @task, serializer: TaskSerializer
        else
          render_error(@task)
        end
      end

      def destroy
        @task.destroy
        head :no_content
      end

      private

      def set_task
        @task = current_user.tasks.find(params[:id])
      end

      def task_params
        params.require(:task).permit(
          :title, 
          :description, 
          :priority, 
          :is_completed, 
          :deadline
        )
      end

      def filter_tasks(tasks)
        tasks = tasks.completed if params[:status] == 'completed'
        tasks = tasks.pending if params[:status] == 'pending'
        tasks = tasks.overdue if params[:overdue] == 'true'
        tasks = tasks.where(priority: params[:priority]) if params[:priority].present?
        tasks
      end

      def pagination_meta(collection)
        {
          current_page: collection.current_page,
          total_pages: collection.total_pages,
          total_count: collection.total_count,
          per_page: collection.limit_value
        }
      end

      def render_error(resource)
        render json: {
          error: {
            message: 'Validation failed',
            errors: resource.errors.full_messages
          }
        }, status: :unprocessable_entity
      end
      end
    end
  end
end