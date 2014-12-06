class CreateTableAttractions < ActiveRecord::Migration
  def self.up
    create_table :attractions do |t|
      t.string :attraction
      t.string :attraction_holiday_iq_id
    end
  end

  def self.down
    drop_table :attractions
  end
end
