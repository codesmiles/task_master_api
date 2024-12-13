
class Api::V1::Auth::AuthController < ApplicationController

  # # Skip authentication check for signup and login
  skip_before_action :authenticate_request, only: [:signup, :login]

  def signup
    user = User.new(user_params)

    if user.save
      #  Generate a token upon successful signup
      token = jwt_encode(user_id: user.id)
      render json: { 
        user: user, 
        token: token 
      }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      # Generate token upon successful login
      token = jwt_encode(user_id: user.id)
      render json: { 
        token: token 
      }, status: :ok
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  def profile
    render json: current_user,  serializer: UserSerializer
  end

  private

  def user_params
    params.permit(:names, :email, :password)
  end
end

