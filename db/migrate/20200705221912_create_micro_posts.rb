class CreateMicroPosts < ActiveRecord::Migration[6.0]
  def change
    create_table :micro_posts do |t|
      t.references :user, index: true
      t.text :content

      t.timestamps
    end
  end
end
