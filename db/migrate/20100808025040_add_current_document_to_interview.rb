class AddCurrentDocumentToInterview < ActiveRecord::Migration
  def self.up
    add_column :interview, :current_document_id, :integer
  end

  def self.down
    remove_column :interview, :current_document_id
  end
end
