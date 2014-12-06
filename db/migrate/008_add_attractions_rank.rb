class AddAttractionsRank < ActiveRecord::Migration
  def change
    add_column    :attractions, :rank, :string
  end
end
