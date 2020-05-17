class PasswordsController < ApplicationController

  def edit
    if params[:email].blank?
      render json: { message: 'Email not present' }
    else
      user = User.find_by(email: params[:email])
      if user.present?
        user.generate_password_token
        render json: { status: 'Reset Password Token Updated in User Object' }, status: :ok
      else
        render json: { message: 'Email address not found' }, status: :unprocessable_entity
      end
    end
  end

  def update
    token = params[:token].to_s
    user = User.find_by(reset_password_token: token)
    if user.present? && user.password_token_valid?
      if user.reset_password!(params[:password])
        render json: { status: 'Updated Successfully' }, status: :ok
      else
        render json: { error: user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: ['Not Valid'] }, status: :not_found
    end
  end

end
