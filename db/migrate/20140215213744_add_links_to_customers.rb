class AddLinksToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :links, :string, :null => '', :default => ''
  end
end
