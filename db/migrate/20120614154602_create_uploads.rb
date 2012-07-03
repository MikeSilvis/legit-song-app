class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :url
      t.string :artist
      t.string :title

      t.timestamps
    end
  end
end
