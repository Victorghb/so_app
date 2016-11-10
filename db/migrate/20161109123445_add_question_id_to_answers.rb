class AddQuestionIdToAnswers < ActiveRecord::Migration
  def change
  	change_table :answers do |t|
  		t.string :question_id
  	end
  end
end
