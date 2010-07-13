class AddIsTariffableToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :is_tariffable, :boolean, :default => false
    add_index :products, :is_tariffable
  end

  def self.down
    remove_column :products, :is_tariffable
  end
end