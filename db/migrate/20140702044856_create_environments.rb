class CreateEnvironments < ActiveRecord::Migration
  def change
    create_table :environments do |t|
      t.string :name
      t.string :protocol
      t.string :adminUrl
      t.string :user
      t.string :password
      t.integer :port

      t.timestamps
    end
  end
end
