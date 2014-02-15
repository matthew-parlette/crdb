class AddLinksToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :links, :string, :null => '', :default => ''
  end
end
