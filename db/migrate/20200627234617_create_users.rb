class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.text :self_introduction, null: false, default: ''

      t.timestamps
    end

    add_index :users, :name, unique: true
  end
end
