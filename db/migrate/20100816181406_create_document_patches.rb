class CreateDocumentPatches < ActiveRecord::Migration
  def self.up
    create_table :document_patches do |t|
      t.references :document
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :document_patches
  end
end
