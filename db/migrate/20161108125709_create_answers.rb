class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :content
      t.string :user_name
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
