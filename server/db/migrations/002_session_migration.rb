class SessionMigration < ActiveRecord::Migration

  def change
    create_table :sessions do |t|
      t.string :token
      t.timestamps null: false
    end
  end 
end
