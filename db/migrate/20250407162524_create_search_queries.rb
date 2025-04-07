class CreateSearchQueries < ActiveRecord::Migration[8.0]
  def change
    create_table :search_queries do |t|
      t.string :query
      t.string :ip
      t.string :session_id
      t.datetime :finalized_at

      t.timestamps
    end
  end
end
