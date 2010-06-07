class CreateContentNodes < ActiveRecord::Migration
  def self.up
    create_table :content_nodes do |t|
      t.string :title
      t.text :body
      t.string :slug
      t.integer :position
      t.integer :category_id
      t.string :code
      t.timestamps
    end

    add_index :content_nodes, :slug
  end

  def self.down
    drop_table :content_nodes
  end
end
