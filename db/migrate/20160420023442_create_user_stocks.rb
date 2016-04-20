class CreateUserStocks < ActiveRecord::Migration
  def change
    create_table :user_stocks do |t|
      t.references :user
      t.references :stock

      t.timestamps null: false
    end
  end
end
