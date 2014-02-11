class AddActiveToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :active, :boolean, :null => true, :default => true
  end
end
