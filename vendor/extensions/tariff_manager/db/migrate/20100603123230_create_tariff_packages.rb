class CreateTariffPackages < ActiveRecord::Migration
  def self.up
    create_table :tariff_packages do |t|
      t.integer :product_id
      t.integer :tariff_id
      t.decimal :price, :precision => 8, :scale => 2, :null => false
    end

    add_index :tariff_packages, :product_id
  end

  def self.down
    drop_table :tariff_packages
  end
end
