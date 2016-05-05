class CreateWatchlists < ActiveRecord::Migration
  def change
    create_table :watchlists do |t|
      t.string :ticker
      t.string :name

      t.timestamps null: false
    end
  end
end
