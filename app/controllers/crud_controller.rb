class CrudController < ApplicationController
  before_action :set_resource, only: [:show, :update, :destroy]

  def index
    resources = resource_class.all
    render json: resources
  end

  def show
    render json: @resource
  end

  def create
    resource = resource_class.new(resource_params)
    
    if resource.save
      render json: resource, status: :created
    else
      render json: resource.errors, status: :unprocessable_entity
    end
  end

  def update
    if @resource.update(resource_params)
      render json: @resource
    else
      render json: @resource.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @resource.destroy
    head :no_content
  end

  private

  def resource_class
    controller_name.classify.constantize
  end

  def resource_params
    params.require(resource_class.model_name.param_key).permit!
  end

  def set_resource
    @resource = resource_class.find(params[:id])
  end
end
