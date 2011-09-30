class AddTypeToShelves < ActiveRecord::Migration
  def change
    add_column :camp_shelves, :type, :string, :limit => 32

    Shelf.all.each do |shelf|
      shelf.update_attribute(:type, 'CampShelf')
    end
  end
end
