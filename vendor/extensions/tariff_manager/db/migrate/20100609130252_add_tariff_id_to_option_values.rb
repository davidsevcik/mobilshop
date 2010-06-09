class AddTariffIdToOptionValues < ActiveRecord::Migration
  def self.up
    add_column :option_values, :tariff_id, :integer
    add_index :option_values, :tariff_id
  end

  def self.down
    remove_column :option_values, :tariff_id
  end
end