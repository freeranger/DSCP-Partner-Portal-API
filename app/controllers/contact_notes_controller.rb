class ContactNotesController < ApplicationController
  before_action :set_contact_note, only: [:show, :update, :destroy]

  # GET /contact_notes
  def index
    @contact_notes = ContactNote.all

    render json: @contact_notes
  end

  # GET /contact_notes/1
  def show
    render json: @contact_note
  end

  # POST /contact_notes
  def create
    @contact_note = ContactNote.new(contact_note_params)

    if @contact_note.save
      render json: @contact_note, status: :created, location: @contact_note
    else
      render json: @contact_note.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contact_notes/1
  def update
    if @contact_note.update(contact_note_params)
      render json: @contact_note
    else
      render json: @contact_note.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contact_notes/1
  def destroy
    @contact_note.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact_note
      @contact_note = ContactNote.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def contact_note_params
      params.fetch(:contact_note, {})
    end
end
