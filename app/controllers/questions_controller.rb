class QuestionsController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user,   only: :destroy

  def index
  	@questions = Question.all.paginate(page: params[:page])
  end

  def show
  	@question = Question.find_by_id(params[:id])
    @answers = @question.answers.paginate(page: params[:page])
    @answer = @question.answers.build
    @answers_count = @question.answers.count
  end

  def new
  	@question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      flash[:success] = "question created!"
      redirect_to home_path
    else
      @feed_items = []
      render home_path
    end
  end

  def destroy
    @question = Question.find_by_id(params [:id])
    if @question.present?
      @question.destroy
      redirect_to home_path
    end
    redirect_to home_path
  end

  private

    def question_params
      params.require(:question).permit(:label, :content)
    end

    def correct_user
      @user = User.find_by_id(params[:id])
      @question = @user.questions.find_by_id(params[:id])
      redirect_to root_url if @question.nil?
    end
end