class PasswordsController < Devise::PasswordsController

  def update
    user = User.find_by_email(params[:email])
    if user.present?
      user.update(:password => params[:password])
      render json: { message: "Update Successfully" }, status: 200
    else
      render json: { message: "Email ID is not valid" }, status: :unprocessable_entity
    end

  end
end