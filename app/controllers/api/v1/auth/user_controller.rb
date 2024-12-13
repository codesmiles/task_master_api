
module Api
  module V1
    module Auth
      class UserController < ApplicationController
      
        def index
          # view all users
          @users = User.all
          render json: @users, each_serializer: UserSerializer, status: :success
        end
        
        def create
          # create a new user
          @user = User.create(user_params)
          if !@user
            render json: @user.errors, status: :unprocessable_entity
          end
          render json: @user,  serializer: UserSerializer, status: :created
        end

        def show
          # Extract email from request body
          @email = params.dig(:user, :email)

          # Show a specific user
          @user = User.find_by(email: @email)
          if @user
            render json: @user, serializer: UserSerializer
          else
            render json: { error: 'User not found' }, status: :not_found
          end
        end
        
        def update
          @user = User.find(params[:id])
      
          if @user.update(user_params)
            render json: @user, status: :ok
          else
            render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
          end
        end
      
      
        def destroy 
          User.find(params[:id]).destroy!
          head :no_content
        end
      private
      
        def user_params
          params.require(:user).permit(:names, :email, :password,)
        end
      end
    end
  end
end
