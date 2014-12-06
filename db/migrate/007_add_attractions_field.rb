class AddAttractionsField < ActiveRecord::Migration
  def change
    add_column    :attractions, :type, :string
    add_column    :attractions, :display_name, :string
    add_column    :attractions, :city, :string
  end
end
