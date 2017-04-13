class NotesController < ApplicationController
  before_action :authenticate_user
  before_action :set_group
  before_action :set_note, only: [:show, :update, :destroy]
  before_action :set_self_links, only: [:show]


  def index
    notes = @group.notes.includes(:user).each {| n | set_self_links n }
    render json: notes, :except=> [:id, :group_id], :include => {:user => {:only => [:first_name, :last_name, :_links],:methods => :_links}}, :methods => :_links
  end

  def show
    render json: @note, :except=> [:id, :group_id], :include => {:user => {:only => [:first_name, :last_name, :_links],:methods => :_links}}, :methods => :_links
  end

  def create
    @note = Note.new(note_params)
    @note.group_id = @group.id
    @note.user_id = current_user.id
    if @note.save
      render json: @note, status: :created, location: group_note_path(@group, @note)
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  def update
    return head :forbidden if @note.user_id != current_user.id
    if @note.update(note_params)
      head :no_content
    else
      render json: @note.errors, status: :unprocessable_entity
    end

  end

  def destroy
    return head :forbidden if @note.user_id != current_user.id
    @note.destroy
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_note
    @note = Note.includes(:user).find(params[:id])
  end

  def set_self_links(note = nil)
    note ||= @note
    note.add_link('self', group_note_path(@group, note))
    note.user.add_link('self', "/users/#{note.user_id}")    #temp until we have a users controller!!!
  end

  def set_note_links
    set_self_link @note
    @note.add_link('user', "/users/#{@note.user_id}")    #temp until we have a users controller!!!
  end

  def note_params
    params.require(:note).permit(:content)
  end
end