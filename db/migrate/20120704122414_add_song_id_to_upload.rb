class AddSongIdToUpload < ActiveRecord::Migration
  def change
    add_column :uploads, :song_id, :string
    add_column :uploads, :artwork, :string
  end
end
