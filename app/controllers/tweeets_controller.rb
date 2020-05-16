class TweeetsController < ApplicationController
  before_action :set_tweeet, only: [:update, :destroy]

  def create
    @tweeet = Tweeet.new(tweeet_params)
    render json: @tweeet.as_json
  end

  def update
    if @tweeet.update(tweeet_params)
      render json: @tweeet.as_json
    else
      render json: @tweeet.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    if @tweeet.destroy
      render json: { message: 'Tweeet deleted successfully!!' }
    else
      render json: @tweeet.errors.full_messages, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweeet
      @tweeet = Tweeet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweeet_params
      params.permit(:id, :tweet, :user_id)
    end
end