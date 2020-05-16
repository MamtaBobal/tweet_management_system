class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:update, :destroy]

  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      render json: @organization.as_json
    else
      render json: @organization.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if @organization.update(organization_params)
      render json: @organization.as_json
    else
      render json: @organization.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    if @organization.destroy
      render json: { message: 'Organization deleted successfully!!' }
    else
      render json: @organization.errors.full_messages, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def organization_params
      params.permit(:id, :name)
    end
end