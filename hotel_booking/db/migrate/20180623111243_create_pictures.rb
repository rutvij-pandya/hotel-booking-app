class CreatePictures < ActiveRecord::Migration[5.1]
  def change
    create_table :pictures do |t|
      t.string :image_url
      # Store 'Hotel' Cover picture & 'Room' pictures in polymorphic association
      t.references :imageable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
