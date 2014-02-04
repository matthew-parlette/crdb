class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :title
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
