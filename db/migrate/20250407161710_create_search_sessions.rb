class CreateSearchSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :search_sessions do |t|
      t.string :ip
      t.string :session_id
      t.string :last_query

      t.timestamps
    end
    add_index :search_sessions, [:ip, :session_id], unique: true
    add_index :search_queries, :query
    add_index :search_queries, :finalized_at
  end
end
