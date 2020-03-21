class ChangeAttributesOfTasks < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      change_table :tasks do |t|
        dir.up do
          t.change :name, :string, null: false
          t.change :description, :text, null: false
        end
        dir.down do
          t.change :name, :string
          t.change :description, :text
        end
      end
    end
  end
end
