class NodesController < ApplicationController
  before_action :set_node, only: %i[ show update destroy ]

  def index
    @nodes = Node.all

    render json: @nodes
  end

  def show
  end

  def create
    @node = Node.new(node_params)

    if @node.save
      render json: { node: @node, message: 'Node created successfully'}, status: :created, location: @node
    else
      render json: { errors: @node.errors.full_messages, message: 'Node not created'}, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
    @node.destroy!
  end

  private

  def set_node
    @node = Node.find(params[:id])
  end

  def node_params
    params.require(:node).permit(:name)
  end
end
