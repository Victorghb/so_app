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
      redirect_to root_path
    else
      @feed_items = []
      flash[:error] = "question not created!"
      redirect_to root_path
    end
  end

  def edit
    @question = Question.find_by_id(params[:id])
  end

  def update
    @question = Question.find_by_id(params[:id])
    if @question.update_attributes(question_params)
      flash[:success] = "Question updated"
      redirect_to @question
    else
      flash[:error] = "Question was not updated"
      render 'edit'
    end
  end

  def destroy
    if @question.present?
      @question.destroy
      flash[:success] = "question destoryed!"
      redirect_to root_path
    else
      flash[:error] = "question not destoryed!"
      redirect_to root_path
    end
  end

  private

    def question_params
      params.require(:question).permit(:label, :content)
    end

    def correct_user
      @user = User.find_by_id(params[:id])
      @question = Question.find_by_id(params[:id])
      redirect_to root_url if @question.nil?
    end
end