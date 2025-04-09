class CreateUserSearchSummaries < ActiveRecord::Migration[8.0]
  def change
    create_table :user_search_summaries do |t|
      t.string :session_id
      t.string :ip
      t.text :search_counts

      t.timestamps
    end
    add_index :user_search_summaries, :session_id, unique: true
  end
end
