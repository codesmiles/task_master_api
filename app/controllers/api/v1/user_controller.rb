class Api::V1::UserController < ApplicationController

  def index
    @users = User.all
    render json: @users
  end
  
  def create
    @user = User.new(book_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
  def show
    # Show a specific user
    @user = User.find_by(id: params[:id]) || User.find_by(email: params[:email])
    if @user
      render json: @user
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
    params.require(:user).permit(:names, :email, :password)
  end
end
