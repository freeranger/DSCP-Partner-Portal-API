class ContactsController < ApplicationController
  before_action :authenticate_user
  before_action :set_contact, only: [:show, :update, :destroy]
  before_action :set_contact_links, only: [:show]

  def index
    if params[:search]
      contacts = Contact.search(params[:search])
    else
      contacts = Contact.all
    end
    contacts.each {| c | set_self_link c }
    render_list_of contacts
  end

  def show
    render json: @contact, :except=> [:created_at, :updated_at], :methods => :_links
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      render json: @contact, status: :created, location: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  def update
    if @contact.update(contact_params)
      render json: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end

  end

  def destroy
    @contact.destroy
  end

  def partners
    if params[:search]
      partners = Contact.partners.search(params[:search])
    else
      partners = Contact.partners
    end
    partners.each {| c | set_self_link c }
    render_list_of partners
  end

  private

    def render_list_of(contacts)
      render json: contacts, except: [:created_at, :updated_at], methods: :_links
    end

    def set_contact
      @contact = Contact.find(params[:id])
    end
  
    def set_contact_links
      set_self_link @contact
    end

    def set_self_link(contact)
      contact.add_link('self', contact_path(contact))
    end

    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :email, :phone,
                                       :phone_alt, :business_name, :website,
                                       :facebook, :instagram, :street_address,
                                       :city, :state, :zip, :partner, :search)
    end
end
