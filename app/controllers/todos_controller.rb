class TodosController < ApplicationController
  before_action :set_todo, only: [:edit, :update, :show, :toggle]

  def index
    @todos = Todo.all
    @new_todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)

    unless @todo.save
      head :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @todo.update(todo_params)
      render "show"
    end
  end

  def show
  end

  def toggle
    @todo.toggle_completed!
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:name)
  end
end
