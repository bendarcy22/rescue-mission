class AnswersController < ApplicationController

  def index
    if params[:question_id].present?
      @answers = Question.find(params[:question_id]).answers
    else
      @answers = Answer.all
    end
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)
    @answer.question = @question
    if @answer.save
      flash[:notice] = 'Answer was created successfully!'
      redirect_to question_path(@question)
    else
      @answer.errors.full_messages.each do |msg|
        flash[:errors] == msg
      end
      render :'questions/show'
    end
  end



  private

  def answer_params
    params.require(:answer).permit(:description)
  end

end
