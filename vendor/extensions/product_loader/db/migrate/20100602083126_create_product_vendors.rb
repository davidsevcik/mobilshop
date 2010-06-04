class CreateProductVendors < ActiveRecord::Migration
  def self.up
    create_table :product_vendors do |t|
      t.string :code
      t.integer :product_id
    end

    add_index :product_vendors, :code
  end

  def self.down
    drop_table :product_vendors
  end
end
