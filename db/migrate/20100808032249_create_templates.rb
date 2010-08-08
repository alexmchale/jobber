class CreateTemplates < ActiveRecord::Migration
  def self.up
    create_table :templates do |t|
      t.references :user
      t.string :name
      t.text :content

      t.timestamps
    end

    add_index :templates, :user_id
  end

  def self.down
    remove_index :templates, :user_id

    drop_table :templates
  end
end
