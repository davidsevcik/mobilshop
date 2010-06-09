class AddPublishedToTariffs < ActiveRecord::Migration
  def self.up
    add_column :tariffs, :published, :boolean, :default => true
  end

  def self.down
    remove_column :tariffs, :published
  end
end