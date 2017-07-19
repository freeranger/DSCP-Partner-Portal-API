class ChangeNotesToGroupNotes < ActiveRecord::Migration[5.0]
  def change
    rename_table :notes, :group_notes
  end
end
