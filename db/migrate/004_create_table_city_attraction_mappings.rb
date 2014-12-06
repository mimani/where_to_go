class CreateTableCityAttractionMappings < ActiveRecord::Migration
  def self.up
    create_table :city_attraction_mappings do |t|
      t.string :city_id
      t.string :attraction_id
    end
  end

  def self.down
    drop_table :city_attraction_mappings
  end
end
