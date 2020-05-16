class TweeetsController < ApplicationController
  before_action :set_tweeet, only: [:update, :destroy]

  def index
    @tweeets = Tweeet.joins(:user).where("users.organization_id =?", current_user.organization.id)
    render json: @tweeets.as_json
  end

  def create
    @tweeet = current_user.tweeets.new(tweeet_params)
    if @tweeet.save
      render json: @tweeet.as_json
    else
        render json: @tweeet.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if current_user.is_admin || @tweeet.is_owner(current_user.id)
      if @tweeet.update(tweeet_params)
        render json: @tweeet.as_json
      else
        render json: @tweeet.errors.full_messages, status: :unprocessable_entity
      end
    else
      render json: { message: 'You are UnAuthorized' }, status: 401
    end
  end

  def destroy
    if current_user.is_admin || @tweeet.is_owner(current_user.id)
      if @tweeet.destroy
        render json: { message: 'Tweeet deleted successfully!!' }
      else
        render json: @tweeet.errors.full_messages, status: :unprocessable_entity
      end
    else
      render json: { message: 'You are UnAuthorized' }, status: 401
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweeet
      @tweeet = Tweeet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweeet_params
      params.permit(:id, :tweet)
    end
end