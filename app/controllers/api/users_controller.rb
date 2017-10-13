class Api::UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:data).
      permit(
        attributes:[
          :name,
          :email,
          :password,
          :birthdate
        ]
      )
  end
end
