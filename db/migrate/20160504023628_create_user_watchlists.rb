class CreateUserWatchlists < ActiveRecord::Migration
  def change
    create_table :user_watchlists do |t|
      t.references :user, index: true, foreign_key: true
      t.references :watchlist, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
