class QuestionsController < ApplicationController
  
  before_action :signed_in_user
  before_action :correct_user,   only: :destroy

  def index
  	@questions = Question.all
  end

  def show
  	@question = Question.find(params[:id])
    @answers = @question.answers.paginate(page: params[:page])
    @answer = @question.answers.build
  end

  def new
  	@question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      flash[:success] = "question created!"
      redirect_to '/'
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @question.destroy
    redirect_to '/'
  end

  private

    def question_params
      params.require(:question).permit(:label, :content)
    end

    def correct_user
      @users = User.all
      @question = users.questions.find_by(id: params[:id])
      redirect_to root_url if @question.nil?
    end
end