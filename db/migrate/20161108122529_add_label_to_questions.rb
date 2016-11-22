class AddLabelToQuestions < ActiveRecord::Migration
  def change
  	change_table :questions do |t|
  		t.string :label
  	end
  end
end
