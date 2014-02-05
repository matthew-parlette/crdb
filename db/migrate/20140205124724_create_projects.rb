class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.date :start_date
      t.date :due_date
      t.date :completed_date
      t.string :status
      t.boolean :completed
      t.references :customer, index: true

      t.timestamps
    end
  end
end
