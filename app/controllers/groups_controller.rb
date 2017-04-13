class GroupsController < ApplicationController
  before_action :authenticate_user
  before_action :set_group, only: [:show, :update, :destroy, :add_group_contact, :delete_group_contact, :list_group_contacts]
  before_action :set_group_links, only: [:show]
  before_action :set_contact, only: [:add_group_contact, :delete_group_contact]

  def index
    groups = Group.all.each {| g | set_self_link g }
    render json: groups, :only=> [:name,:description], :methods => :_links
  end

  def show
    render json: @group, :except=> [:created_at, :updated_at], :methods => :_links
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      render json: @group, status: :created, location: @group
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  def update
    if @group.update(group_params)
      head :no_content
    else
      render json: @group.errors, status: :unprocessable_entity
    end

  end

  def destroy
    @group.destroy
  end


  def list_group_contacts
    contacts = @group.contacts.each {| c | set_contact_self_link c }
    render json: contacts, :only=> [:first_name, :last_name, :email, :business_name], :methods => :_links
  end

  def add_group_contact
    @group.contacts << @contact
    @group.save!
    head :created
  end

  def delete_group_contact
    @group.contacts.delete @contact
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def set_contact
    @contact = Contact.find(params[:contact_id])
  end


  def set_group_links
    set_self_link @group
    @group.add_link('contacts', group_contacts_path(@group))
    @group.add_link('links', group_links_path(@group))
    @group.add_link('notes', group_notes_path(@group))
  end

  def set_self_link(group)
    group.add_link('self', group_path(group))
  end

  def set_contact_self_link(contact)
    contact.add_link('self', contact_path(contact))
  end

  def group_params
    params.require(:group).permit(:name, :description)
  end
end
