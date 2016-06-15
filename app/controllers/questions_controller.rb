class QuestionsController < ApplicationController
  def index
    @questions = Question.all.order("created_at DESC")
  end

  def show
    @question = Question.find(params[:id])
    @answer_to_question = @question.answers.order("created_at ASC")
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:notice] = "Question was created successfully"
      redirect_to question_path(@question)
    else
      @question.errors.full_messages.each do |msg|
        flash[:errors] == msg
      end
      render :new
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(question_params)
      flash[:notice] = 'Question was updated successfully!'
      redirect_to question_path(@question)
    else
      @question.errors.full_messages.each do |msg|
        flash[:errors] == msg
      end
      render :new
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.answers.destroy_all
    @question.destroy
    flash[:notice] = "Question was deleted successfully"
    redirect_to questions_path
  end




  private

  def question_params
    params.require(:question).permit(:title, :description)
  end
end
