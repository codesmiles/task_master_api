class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.string :priority
      t.boolean :is_completed
      t.datetime :deadline
      t.references :user_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
