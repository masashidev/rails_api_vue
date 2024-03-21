class VariablesController < ApplicationController
  before_action :set_variable, only: %i[ show update destroy ]

  # GET /variables
  def index
    @variables = Variable.all

    render json: @variables
  end

  # GET /variables/1
  def show
    render json: @variable
  end

  # POST /variables
  def create
    @variable = Variable.new(variable_params)

    if @variable.save
      render json: @variable, status: :created, location: @variable
    else
      render json: @variable.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /variables/1
  def update
    if @variable.update(variable_params)
      render json: @variable
    else
      render json: @variable.errors, status: :unprocessable_entity
    end
  end

  # DELETE /variables/1
  def destroy
    @variable.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_variable
      @variable = Variable.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def variable_params
      params.fetch(:variable, {})
    end
end
