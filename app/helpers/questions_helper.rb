module QuestionsHelper
  def all_questions
	  @all_questions = Question.all
  end
end
