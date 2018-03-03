class TodosController < ApplicationController
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

  private

  def todo_params
    params.require(:todo).permit(:name)
  end
end
