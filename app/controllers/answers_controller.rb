class AnswersController < ApplicationController
  before_action :signed_in_user

  def index
    @answers = Answer.all.paginate(page: params[:page])
  end

  def show
  	@answer = Answer.find_by_id(params[:id])
  end

  def new
  	@answer = Answer.new
  end

  def create
    @answer = Answer.new answer_params

    if @answer.save
      flash[:success] = "answer created!"
      redirect_to question_path(@answer.question_id)
    else
      flash[:error] = "Sorry, but your answer wasn`t created!"
      redirect_to question_path(@answer.question_id)
    end
  end

  def destroy
  	@answer = current_user.answers.find_by(id: params[:id])
    if @answer.present?
      @answer.destroy
    end
    redirect_to question_path(@answer.question_id)
  end

  private
    def answer_params
      params.require(:answer).permit(:user_name, :content, :user_id, :question_id)
    end
end