class AddSessionEnvToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :environment, :string
    change_column :sessions, :environment, :string, null: false    
  end
end
