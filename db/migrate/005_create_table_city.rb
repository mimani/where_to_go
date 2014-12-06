class CreateTableCity < ActiveRecord::Migration
  def self.up
    create_table :cities do |t|
      t.string :city
      t.string :city_holiday_iq_id
      t.string :state
    end
  end

  def self.down
    drop_table :cities
 end
end
