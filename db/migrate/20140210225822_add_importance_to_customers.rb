class AddImportanceToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :importance, :integer, :null => 0, :default => 0
  end
end
