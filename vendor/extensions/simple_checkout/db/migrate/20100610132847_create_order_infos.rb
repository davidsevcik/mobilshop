class CreateOrderInfos < ActiveRecord::Migration
  def self.up
    create_table :order_infos do |t|
      t.integer :order_id
      t.string :name
      t.string :surname
      t.string :company
      t.string :ic
      t.string :dic
      t.string :street
      t.string :city
      t.string :zip
      t.string :country, :default => 'Česká republika'
      t.string :phone
      t.string :email
      t.boolean :number_transfer, :default => false

      t.timestamps
    end

    add_index :order_infos, :order_id
  end

  def self.down
    drop_table :order_infos
  end
end
