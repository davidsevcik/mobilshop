class CreateOperators < ActiveRecord::Migration
  def self.up
    create_table :operators do |t|
      t.string :name
      t.integer :position
    end
  end

  def self.down
    drop_table :operators
  end
end
