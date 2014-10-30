class AddLocationtoSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :location, :string
    change_column :sessions, :location, :string, null: false
  end
end
