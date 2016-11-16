class AddUserNameToAnswers < ActiveRecord::Migration
  def change
  	change_table :answers do |t|
  		t.string :user_name
  	end
  end
end
