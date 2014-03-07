class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.integer :project_id
      t.boolean :completed, default: false, null: false
      
      t.references :project, index: true

      t.timestamps
    end
  end
end
