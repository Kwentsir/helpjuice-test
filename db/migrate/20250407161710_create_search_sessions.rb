class CreateSearchSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :search_sessions do |t|
      t.string :ip
      t.string :session_id
      t.string :last_query

      t.timestamps
    end
  end
end
