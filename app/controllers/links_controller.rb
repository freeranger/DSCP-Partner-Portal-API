class LinksController < ApplicationController
  before_action :authenticate_user
  before_action :set_group
  before_action :set_link, only: [:show, :update, :destroy]
  before_action :set_self_link, only: [:show]

  def index
    links = @group.links.each {| l | set_self_link l }
    render json: links, :except=> [:id,  :created_at, :updated_at], :methods => :_links
  end

  def show
    render json: @link, :except=> [:id,  :created_at, :updated_at], :methods => :_links
  end

  def create
    @link = Link.new(link_params)
    @link.group_id = @group.id
    if @link.save
      render json: @link, status: :created, location: group_link_path(@group, @link)
    else
      render json: @link.errors, status: :unprocessable_entity
    end
  end

  def update
    if @link.update(link_params)
      head :no_content
    else
      render json: @link.errors, status: :unprocessable_entity
    end

  end

  def destroy
    @link.destroy
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_link
    @link = Link.find(params[:id])
  end

  def set_self_link(link = nil)
    link ||= @link
    link.add_link('self', group_link_path(@group, link))
  end


  def link_params
    params.require(:link).permit(:title, :destination)
  end
end
