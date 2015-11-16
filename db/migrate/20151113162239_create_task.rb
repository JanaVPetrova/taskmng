class CreateTask < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.text :description
      t.string :aasm_state, null: false
      t.references :user

      t.timestamps
    end
  end
end
