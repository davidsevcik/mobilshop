class CreateTariffs < ActiveRecord::Migration
  def self.up
    create_table :tariffs do |t|
      t.integer :operator_id
      t.string :name
      t.text :desc
      t.text :desc_long
      t.decimal :price, :precision => 10, :scale => 2
      t.text :gift
      t.string :package_price
      t.integer :position
    end

    add_index :tariffs, :operator_id
  end

  def self.down
    drop_table :tariffs
  end
end
